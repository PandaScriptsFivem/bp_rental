Config = {}

Config.BikePedModel = "a_f_m_eastsa_01"
Config.BikeLocations = {
    vec4(-523.4631, -265.2684, 35.3118, 214.3705)
}

Config.Bikes = { -- FONTOS A .webp
    {label = "BMX", lehivo = "bmx", kep = "https://docs.fivem.net/vehicles/bmx.webp", icon = "bicycle", price = 500}, -- icon: https://fontawesome.com/icons
    {label = "Cruiser", lehivo = "cruiser", kep = "https://docs.fivem.net/vehicles/cruiser.webp", icon = "bicycle", price = 100}
}

Config.ShowBlip = true
Config.BlipSprite = 226
Config.BlipColor = 21

Config.Locale = {
    Name = 'Bicikli bérlés',
    BlipName = "Bringa bérlés",
    dollarpermin = "$/perc",
    method = "Fizetési mód",
    card = "Bankkártya 💳",
    bankdesc = "Csak bankkártyás fizetés elérhető!",
    inputlabel = 'Mennyi időre',
    inputdesc = 'Írd be mennyi időre bérled (perc)',
    nomoney = 'Nincs elegendő pénzed ',
    dollarmissing = "$ hiányzik",
    cash = "Kézpénz 💷",
    cashdesc = "Csak készpénzes fizetés elérhető!"
}