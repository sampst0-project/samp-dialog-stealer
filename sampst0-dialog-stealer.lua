script_name('sampst0-dialog-stealer')

local sampev = require('samp.events')

local cache = ""

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    cache = string.format("ShowPlayerDialogEx(playerid, %d, %d, \"%s\", \"%s\", \"%s\", \"%s\");", dialogId, style, title, text, button1, button2)
end

function main()
    repeat wait(0) until isSampAvailable()
    logger("/dialog -> for save dialog texts")
    
    sampRegisterChatCommand("dialog", function()
        local ip, port = sampGetCurrentServerAddress();
        createDirectory("sampst0");
        local file = io.open(string.format("sampst0\\%s_%d.txt", ip, port), "w");
        file:write(string.format("%s", cache));
        file:close();
        logger("Dialog Saved.");
    end)
end

function logger(text)
    sampAddChatMessage("{FF6347}[sampst0]: {ffffff}"..text, -1)
end
