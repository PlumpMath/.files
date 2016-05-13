local awful = require("awful")

-- {{{ Autostart
--Autostart scripting
function run_once(command, class, tag)
   -- create move callback
   local callback
   callback = function(c)
      if c.class == class then
	 awful.client.movetotag(tag, c)
	 client.remove_signal("manage", callback)
      end
   end
   client.add_signal("manage", callback)
   -- now check if not already running!
   local findme = command
   local firstspace = findme:find(" ")
   if firstspace then
      findme = findme:sub(0, firstspace-1)
   end
   -- finally run it
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. command .. ")")
end

run_once("~/.config/egenSkit/mouseAndKeyboard.bash")
run_once("firefox", "Firefox", tags[1][2])
run_once("volumeicon")
run_once("nm-applet")
run_once("xscreensaver -no-splash")
run_once("audacious", "Audacious", tags[1][5])
run_once("emacs --daemon");
-- run_once("evolution", "Evolution", tags[1][3])
run_once("sleep 5 && x-terminal-emulator -e mosh --ssh='ssh -p 9001' rovanion.se -- screen -rd weechat" , "Firefox", tags[1][2])
run_once("sleep 1 && nice -n 19 conky")
run_once("sleep 5 && nice -n 19 redshift")
run_once("sleep 10 && nice -n 19 dropbox start")
--}}}
