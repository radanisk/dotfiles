#!/bin/sh

# Render tmux window list with powerline separators.
# Reads colors and separator from tmux user options if set.

get_opt() {
  tmux show -gqv "$1"
}

base_bg=$(get_opt '@pl_base_bg')
inactive_bg=$(get_opt '@pl_win_bg')
inactive_fg=$(get_opt '@pl_win_fg')
active_bg=$(get_opt '@pl_win_active_bg')
active_fg=$(get_opt '@pl_win_active_fg')
left_bg=$(get_opt '@pl_left_bg')
sep=$(get_opt '@pl_left')

: "${base_bg:=#282828}"
: "${inactive_bg:=#3c3836}"
: "${inactive_fg:=#a89984}"
: "${active_bg:=#fabd2f}"
: "${active_fg:=#282828}"
: "${left_bg:=$base_bg}"
: "${sep:=}"

tmux list-windows -F "#{window_index} #{window_active} #{window_name}" |
  awk \
    -v base_bg="$base_bg" \
    -v inactive_bg="$inactive_bg" \
    -v inactive_fg="$inactive_fg" \
    -v active_bg="$active_bg" \
    -v active_fg="$active_fg" \
    -v left_bg="$left_bg" \
    -v sep="$sep" \
    '
    function win_bg(i) { return (active[i] == "1") ? active_bg : inactive_bg }
    function win_fg(i) { return (active[i] == "1") ? active_fg : inactive_fg }
    function win_attr(i) { return (active[i] == "1") ? "bold" : "nobold" }

    {
      idx[NR] = $1
      active[NR] = $2
      name[NR] = $3
      if (NF > 3) {
        for (i = 4; i <= NF; i++) {
          name[NR] = name[NR] " " $i
        }
      }
    }
    END {
      if (NR > 0 && sep != "") {
        first_bg = win_bg(1)
        printf("#[fg=%s,bg=%s,nobold]%s", left_bg, first_bg, sep)
      }
      for (i = 1; i <= NR; i++) {
        curr_bg = win_bg(i)
        curr_fg = win_fg(i)
        curr_attr = win_attr(i)
        printf("#[fg=%s,bg=%s,%s] %s:%s ", curr_fg, curr_bg, curr_attr, idx[i], name[i])
        if (i < NR) {
          next_bg = win_bg(i + 1)
          if (active[i + 1] == "1") {
            # Left arrow of active window: inactive fg on active bg.
            sep_fg = inactive_bg
            sep_bg = active_bg
          } else if (active[i] == "1") {
            sep_fg = curr_bg
            sep_bg = next_bg
          } else {
            sep_fg = next_bg
            sep_bg = curr_bg
          }
        } else {
          next_bg = base_bg
          if (active[i] == "1") {
            sep_fg = curr_bg
            sep_bg = base_bg
          } else {
            sep_fg = inactive_bg
            sep_bg = base_bg
          }
        }
        printf("#[fg=%s,bg=%s,nobold]%s", sep_fg, sep_bg, sep)
      }
    }
  '
