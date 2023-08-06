--[[
     Color temperature to RGB value converter LUA plugin for GrandMA lighting console. 
     Usefull when Astera fixtures are used in RGB only mode. 
     Based on the table of value from ATSERA : https://astera-led.com/wp-content/uploads/DMX-Values-for-common-Colors.pdf
     Written by Eric Kirchhoffer
     v1.0 6th august 2023
--]]
function main ()
    local ku = tonumber(TextInput('Enter desired color temp in °K (Astera fixtures only)', '5600')) -- ku : user desired color temp in kelvin
    local ka = 0
    local kelvin = {
        -- +50°K
        [1750] = {255, 131, 22},
        [1800] = {255, 133, 25},
        [1850] = {255, 135, 28},
        [1900] = {255, 138, 31},
        [1950] = {255, 140, 34},
        [2000] = {255, 142, 36},
        [2050] = {255, 144, 39},
        [2100] = {255, 146, 42},
        [2150] = {255, 148, 44},
        [2200] = {255, 150, 47},
        [2250] = {255, 152, 49},
        [2300] = {255, 153, 52},
        [2350] = {255, 155, 54},
        [2400] = {255, 157, 56},
        [2450] = {255, 158, 59},
        [2500] = {255, 160, 61},
        [2550] = {255, 162, 63},
        [2600] = {255, 163, 65},
        [2650] = {255, 165, 67},
        [2700] = {255, 166, 70},
        [2750] = {255, 167, 72},
        [2800] = {255, 169, 74},
        [2850] = {255, 170, 76},
        [2900] = {255, 171, 78},
        [2950] = {255, 172, 79},
        [3000] = {255, 174, 81},
        [3050] = {255, 175, 83},
        [3100] = {255, 176, 85},
        [3150] = {255, 177, 87},
        [3200] = {255, 178, 89},
        [3250] = {255, 179, 91},
        [3300] = {255, 180, 92},
        [3350] = {255, 181, 94},
        [3400] = {255, 182, 96},
        [3450] = {255, 183, 97},
        [3500] = {255, 184, 99},
        [3550] = {255, 185, 101},
        [3600] = {255, 186, 102},
        [3650] = {255, 187, 104},
        [3700] = {255, 188, 105},
        [3750] = {255, 189, 107},
        [3800] = {255, 190, 109},
        [3850] = {255, 190, 110},
        [3900] = {255, 191, 112},
        [3950] = {255, 192, 113},
        [4000] = {255, 193, 115},
        [4050] = {255, 194, 116},
        [4100] = {255, 194, 117},
        [4150] = {255, 195, 119},
        [4200] = {255, 196, 120},
        [4250] = {255, 197, 122},
        [4300] = {255, 197, 123},
        [4350] = {255, 198, 124},
        [4400] = {255, 199, 126},
        [4450] = {255, 199, 127},
        [4500] = {255, 200, 128},
        [4550] = {255, 201, 129},
        [4600] = {255, 201, 131},
        [4650] = {255, 202, 132},
        [4700] = {255, 203, 133},
        [4750] = {255, 203, 134},
        [4800] = {255, 204, 135},
        [4850] = {255, 204, 137},
        [4900] = {255, 205, 138},
        [4950] = {255, 206, 139},
        [5000] = {255, 206, 140},
        [5050] = {255, 207, 141},
        [5100] = {255, 207, 142},
        [5150] = {255, 208, 143},
        [5200] = {255, 208, 144},
        [5250] = {255, 209, 145},
        [5300] = {255, 209, 146},
        [5350] = {255, 210, 147},
        [5400] = {255, 210, 148},
        [5450] = {255, 211, 149},
        [5500] = {255, 211, 150},
        [5550] = {255, 212, 151},
        [5600] = {255, 212, 152},
        [5650] = {255, 213, 153},
        [5700] = {255, 213, 154},
        [5750] = {255, 214, 155},
        [5800] = {255, 214, 156},
        [5850] = {255, 214, 157},
        [5900] = {255, 215, 158},
        [5950] = {255, 215, 159},
        [6000] = {255, 216, 159},
        -- + 250°K
        [6250] = {255, 218, 164},
        [6500] = {255, 219, 167},
        [6750] = {255, 221, 171},
        [7000] = {255, 223, 175},
        [7250] = {255, 224, 178},
        [7500] = {255, 225, 181},
        [7750] = {255, 227, 184},
        [8000] = {255, 228, 187},
        [8250] = {255, 229, 189},
        [8500] = {255, 230, 192},
        [8750] = {255, 231, 194},
        [9000] = {255, 232, 196},
        [9250] = {255, 233, 198},
        [9500] = {255, 234, 200},
        [9750] = {255, 234, 202},
        [10000] = {255,	235, 204},
        -- + 1000°K
        [11000] = {255,	238, 211},
        [12000] = {255,	240, 216},
        [13000] = {255,	242, 221},
        [14000] = {255,	244, 225},
        [15000] = {255,	245, 228},
        [16000] = {255,	246, 231},
        [17000] = {255,	247, 234},
        [18000] = {255,	248, 236},
        [19000] = {255,	249, 239},
        [20000] = {255,	250, 240}
    }

    -- 1st group (below 1776°K)
    if ku < 1776 then
        ka = 1750


    -- 2nd group (from 1776°K to 6125°K with encrement of 50°K)
    elseif 1775 < ku and ku < 5976 then
        for i=1800, 5950, 50 do
            if (i-25) < ku and ku < (i+26) then
                ka = i
                break
            end
        end


    -- 3rd group (from 6026°K to 6125°K = 6000°K)
    elseif 5975 < ku and ku < 6126 then
        ka = 6000


    -- 4th group (from 6126°K to 9775°K with encrement of 250°K)
    elseif 6125 < ku and ku < 9876 then
        for i=6250, 9750, 250 do
            if (i-125) < ku and ku < (i+126) then
                ka = i
                break
            end
        end


    -- 5th group (from 9776°K to 10500°K = 10000°K)
    elseif 9875 < ku and ku < 10501 then
        ka = 10000


    -- 6th group (from 10501°K to 19500°K with encrement of 1000°K)
    elseif 10500 < ku and ku < 19501 then
        for i=11000, 19000, 1000 do
            if (i-500) < ku and ku < (i+501) then
                ka = i
                break
            end
        end


    -- 7th group (above 19500°K)
    elseif ku > 19500 then
        ka = 20000
    end


    Printf('Desired color temp : ' .. ku .. '°K -> ' .. ka .. '°K')
    Printf('R = ' .. kelvin[ka][1] .. ', G = ' .. kelvin[ka][2] .. ', B = ' .. kelvin[ka][3])
    Cmd('Attribute "ColorRGB_R" At Decimal8 ' .. kelvin[ka][1])
    Cmd('Attribute "ColorRGB_G" At Decimal8 ' .. kelvin[ka][2])
    Cmd('Attribute "ColorRGB_B" At Decimal8 ' .. kelvin[ka][3])


end
return main