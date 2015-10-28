hook.Add("PlayerSay", "mikey.plugins.adminchat", function(objPl, strText, iTeam)
  if(string.sub(strText, 1, 1) == "@") then
    strText = string.sub(strText, 2)

    if(string.len(strText) > 0) then
      local tblTargets = {objPl}

      for k,v in pairs(player.GetAll()) do
        if(v ~= objPl and v:isMod()) then
          table.insert(tblTargets, v)
        end
      end

      mikey.network.sendMessage({
        ["name"]  = "adminchat.message",
        ["to"]    = tblTargets,
        ["from"]  = objPl,
        ["data"]  = {
          ["message"] = strText,
        }
      })
    else
      objPl:sendMessage(mikey.colors.error, "[!] ", color_white, "You must enter a message to send to staff members!")
    end

    return ""
  end
end)