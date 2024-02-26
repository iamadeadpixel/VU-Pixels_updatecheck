-- Code from https://gitlab.com/n4gi0s/vu-mapvote by N4gi0s
-- Modified for general use by GreatApo
-- Pimped version by Iamadeadpixel

-- Reads the current mod version on the server
require('version')

-- If local version is up2date
    local s_currentMSG = ("VU-Pixels_updatecheck seems to be up2date")

-- If local version is out of date
    local s_updateMSG = ("VU-Pixels_updatecheck seems to be out of date!")

    -- Error message when the mod.json could not be fetched
local s_ErrorMSG = "Guru Meditation 404: Seems the owner changed something, Or github has a isue"

-- Make sure this point on github to your project
    local s_githublink = ("https://github.com/iamadeadpixel/VU-Pixels_Tickets")

-- github link to your mod.json file
    local CheckURL = "http://test.xs4non.nl:85/mod.json"

-- Show up-to-date message
    local ShowUptodateMsg = true

function GetCurrentVersion()
    s_Options = HttpOptions({}, 10);
    s_Options.verifyCertificate = false; --ignore cert for wine users
    local res = Net:GetHTTP(CheckURL, s_Options)

    if res.status ~= 200 then
        return null;
    end

    json = json.decode(res.body);
    
    if json.Version ~= nil then
        return json.Version,json.Reason;

	elseif json.tag_name ~= nil then
		return json.tag_name:gsub(" ", ""):gsub("^v", "")
	else
		return nil
	end
end


function checkVersion()
    local CurrentVersion = GetCurrentVersion()

	if CurrentVersion == nil then
-- prints a message when the mod.json could not be found
        print("***************************************");
        print('** '..s_ErrorMSG..' **' );
    	print("***************************************");
		return true
        
    elseif CurrentVersion ~= localModVersion then
-- Prints a message when the project on hithub is updated
        print("***************************************");
        print('** '..s_updateMSG..' **' );
        print('** Please visit '..s_githublink..''  );
	    print('** Changed Version on github is ('..json.Version..') - Local version:('..localModVersion..')')
	    print('** Reason for update: ('..json.Reason..')')
	    print("***************************************");
    return false

    elseif CurrentVersion == localModVersion and ShowUptodateMsg then
-- Prints a message when the project on hithub is the same as the server version
        print("***************************************");
        print('** '..s_currentMSG..' **' );
	    print('Version on github is ('..json.Version..') - Local version:('..localModVersion..')...')
	    print("***************************************");
		return true
    end
end

return checkVersion();

