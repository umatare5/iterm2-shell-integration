# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

if begin; status --is-interactive; and not functions -q -- iterm2_status; and [ "$ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX""$TERM" != screen ]; and [ "$TERM" != dumb ]; and [ "$TERM" != linux ]; end

  functions -c fish_prompt iterm2_fish_prompt

  function iterm2_set_user_var
    printf "\033]1337;SetUserVar=%s=%s\007" $argv[1] (printf "%s" $argv[2] | base64 | tr -d "\n")
  end

  function iterm2_print_user_vars
    iterm2_set_user_var awsProfile $AWS_PROFILE
    iterm2_set_user_var gcpProject $GCP_PROJECT
  end

  function iterm2_common_prompt
    iterm2_print_user_vars
  end

  function fish_prompt
    iterm2_common_prompt
    printf "%b" (string join "\n" (iterm2_fish_prompt))
  end
end
