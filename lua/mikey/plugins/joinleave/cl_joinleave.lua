hook.Add("ChatText", "mikey.plugins.joinleave", function(iIndex, strNick, strText, strType)
  if(strType == "joinleave") then return true end
end)

mikey.network.receive("joinleave.join", function(tblData)
  local strNick     = tblData["nick"]
  local strSteamID  = tblData["steamid"]
  local bIsBot      = tblData["bot"]
  local iUserID     = tblData["userid"]

  local tblMessage = {}

  if(bIsBot) then
    tblMessage = {
      mikey.colors.primary, "→ ",
      color_white,          "A silly bot named ",
      mikey.colors.alt2,    strNick,
      color_white,          " has joined",
    }
  else
    tblMessage = {
      mikey.colors.primary, "→ ",
      color_white,          "Player ",
      mikey.colors.alt3,    strNick,
      color_white,          "(",
      mikey.colors.alt3,    strSteamID,
      color_white,          ") has connected",
    }
  end

  chat.AddText(unpack(tblMessage))
end)


local tblTranslate = {
  ["Disconnect by user"]  = "disconnected",
  ["Client timed out"]    = "timed out",
  ["Connection closing"]  = "lost connection",
}

mikey.network.receive("joinleave.leave", function(tblData)
  local strNick     = tblData["nick"]
  local strSteamID  = tblData["steamid"]
  local bIsBot      = tblData["bot"]
  local iUserID     = tblData["userid"]
  local strReason   = tblData["reason"]

  local tblMessage = {}

  --if(bIsBot) then return end

  tblMessage = {
    mikey.colors.secondary, "← ",
    color_white,            "Player ",
    mikey.colors.alt3,      strNick,
    color_white,            " has ",
    mikey.colors.secondary,  tblTranslate[strReason] or strReason,
  }

  chat.AddText(unpack(tblMessage))
end)