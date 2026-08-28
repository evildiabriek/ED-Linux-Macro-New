import discord
import datetime
import os
import sys
import requests
import re

macro_icon = "https://raw.githubusercontent.com/evildiabriek/ED-Linux-Macro-New/refs/heads/master/EdLInuxMacro.png"

def parse_config(filepath):
    webhooks = []
    private_server = None

    pattern = re.compile(r'\[(\w)\]\s*>(.*?)<')

    with open(filepath, 'r') as f:
        for line in f:
            match = pattern.match(line.strip())
            if not match:
                continue
            tag, value = match.groups()

            if tag == 'w':
                webhooks.append(value)
            elif tag == 'p' and private_server is None:
                private_server = value

    return webhooks, private_server

cfg_file = f"{os.getenv("HOME")}/.edlinuxmacro/config.cfg"

webhooks, serv_url = parse_config(cfg_file)
version_macro = 'beta'

windy_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Windy 🍃",
        color=discord.Color.from_rgb(123, 209, 255),
        timestamp=datetime.datetime.now()
    )

windy_embed.set_thumbnail(url="https://cresqnt.com/raw-images/WINDY.png")

windy_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

windy_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

snowy_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Snowy ☃️",
        color=discord.Color.from_rgb(0, 255, 255),
        timestamp=datetime.datetime.now()
    )

snowy_embed.set_thumbnail(url="https://cresqnt.com/raw-images/SNOWY.png")

snowy_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

snowy_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

rainy_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Rainy 🌊",
        color=discord.Color.og_blurple(),
        timestamp=datetime.datetime.now()
    )

rainy_embed.set_thumbnail(url="https://cresqnt.com/raw-images/RAINY.png")

rainy_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

rainy_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

sandtorm_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Sandstorm ⏳",
        color=discord.Color.dark_gold(),
        timestamp=datetime.datetime.now()
    )

sandtorm_embed.set_thumbnail(url="https://cresqnt.com/raw-images/SAND_STORM.png")

sandtorm_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

sandtorm_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

hell_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Hell 🔥",
        color=discord.Color.dark_red(),
        timestamp=datetime.datetime.now()
    )

hell_embed.set_thumbnail(url="https://cresqnt.com/raw-images/HELL.png")

hell_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

hell_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

starfall_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Starfall 🌌",
        color=discord.Color.blue(),
        timestamp=datetime.datetime.now()
    )

starfall_embed.set_thumbnail(url="https://cresqnt.com/raw-images/STARFALL.png")

starfall_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

starfall_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

heaven_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Heaven 🪽",
        color=discord.Color.gold(),
        timestamp=datetime.datetime.now()
    )

heaven_embed.set_thumbnail(url="https://cresqnt.com/raw-images/HEAVEN.png")

heaven_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

heaven_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

corruption_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Corruption 💜",
        color=discord.Color.dark_purple(),
        timestamp=datetime.datetime.now()
    )

corruption_embed.set_thumbnail(url="https://cresqnt.com/raw-images/CORRUPTION.png")

corruption_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

corruption_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

null_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Null ⬛",
        color=discord.Color.from_rgb(198, 195, 181),
        timestamp=datetime.datetime.now()
    )

null_embed.set_thumbnail(url="https://cresqnt.com/raw-images/NULL.png")

null_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

null_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

dreamspace_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Dreamspace 💤",
        color=discord.Color.from_rgb(255, 192, 203),
        timestamp=datetime.datetime.now()
    )

dreamspace_embed.set_thumbnail(url="https://cresqnt.com/raw-images/DREAMSPACE.png")

dreamspace_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

dreamspace_embed.set_image(url="https://c.tenor.com/ijsnliG5ZegAAAAd/tenor.gif")

dreamspace_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

glitched_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Glitched 🗿",
        color=discord.Color.dark_green(),
        timestamp=datetime.datetime.now()
    )

glitched_embed.set_thumbnail(url="https://cresqnt.com/raw-images/GLITCHED.png")

glitched_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

glitched_embed.set_image(url="https://c.tenor.com/pkhxZKY6augAAAAC/tenor.gif")

glitched_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

cyberspace_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Cyberspace 🌐",
        color=discord.Color.dark_blue(),
        timestamp=datetime.datetime.now()
    )

cyberspace_embed.set_thumbnail(url="https://cresqnt.com/raw-images/CYBERSPACE.png")

cyberspace_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

cyberspace_embed.set_image(url="https://c.tenor.com/L942HwJ-GSoAAAAC/tenor.gif")

cyberspace_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

singularity_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Singularity ☄️",
        color=discord.Color.dark_orange(),
        timestamp=datetime.datetime.now()
    )

singularity_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/f/f7/SingularityBiome.png/revision/latest?cb=20260426050520")

singularity_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

singularity_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

graveyard_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Graveyard 🪦",
        color=discord.Color.greyple(),
        timestamp=datetime.datetime.now()
    )

graveyard_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/9/90/Graveyard_Biome.png/revision/latest?cb=20241130062132")

graveyard_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

graveyard_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

pumpkin_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Pumpkin Moon 🎃",
        color=discord.Color.orange(),
        timestamp=datetime.datetime.now()
    )

pumpkin_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/8/80/Hallowed_Biome.png/revision/latest?cb=20241130063430")

pumpkin_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

pumpkin_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

blazing_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Blazing Sun ☀️",
        color=discord.Color.yellow(),
        timestamp=datetime.datetime.now()
    )

blazing_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/3/3d/Blazing_sun.png/revision/latest?cb=20250705202847")

blazing_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

blazing_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

blood_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Blood Rain 🩸",
        color=discord.Color.brand_red(),
        timestamp=datetime.datetime.now()
    )

blood_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/e/e5/Bloodrain.png/revision/latest?cb=20251018035833")

blood_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

blood_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

aurora_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Aurora ❄️",
        color=discord.Color.light_grey(),
        timestamp=datetime.datetime.now()
    )

aurora_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/d/d7/Aurora_Biome.png/revision/latest?cb=20251223100640")

aurora_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

aurora_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

eggland_embed = discord.Embed(
        title="Biome detected !",
        description="# > Biome started - Eggland 🐣",
        color=discord.Color.green(),
        timestamp=datetime.datetime.now()
    )

eggland_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/7/7e/Eggland_Biome.jpg/revision/latest?cb=20260330151134")

eggland_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

eggland_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

realm_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Biome started - THE HYPERSPACE REALM 🌀 \n (admin abuse yay)",
        color=discord.Color.blue(),
        timestamp=datetime.datetime.now()
    )

realm_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/b/ba/AnotherRealmBiome.png/revision/latest/scale-to-width-down/1000?cb=20250906010227")

realm_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

realm_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

thenull_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Biome started - THE NULL'S EXISTENCE 🕖 \n (admin abuse yay)",
        color=discord.Color.darker_grey(),
        timestamp=datetime.datetime.now()
    )

thenull_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/5/54/MastermindBiomeUpdated.png/revision/latest?cb=20260220114807")

thenull_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

thenull_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

citadel_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Biome started - THE CITADEL OF ORDERS 🏛️ \n (admin abuse yay)",
        color=discord.Color.yellow(),
        timestamp=datetime.datetime.now()
    )

citadel_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/9/9f/CitadelofOrders.png/revision/latest?cb=20260215040539")

citadel_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

citadel_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

redmoon_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Biome started - The Red Full Moon 🌑 \n (admin abuse yay)",
        color=discord.Color.dark_red(),
        timestamp=datetime.datetime.now()
    )

redmoon_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/4/47/NewUnknownBiomePic.png/revision/latest?cb=20251101091142")

redmoon_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

redmoon_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

unknown_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Unknown Biome ❓ \n (What this biome bruuh)",
        color=discord.Color.dark_magenta(),
        timestamp=datetime.datetime.now()
    )

unknown_embed.set_thumbnail(url="https://cdn.discordapp.com/attachments/1498357978279968931/1499836500647346256/image0.gif")

unknown_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

unknown_embed.set_image(url="https://c.tenor.com/jrwILOUFYhsAAAAC/tenor.gif")

unknown_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

mari_embed = discord.Embed(
        title="Merchant detected !",
        description=f"# > Mari has arrived on the island. 👤",
        color=discord.Color.lighter_grey(),
        timestamp=datetime.datetime.now()
    )

mari_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/e/e2/MariRender.png/revision/latest/scale-to-width-down/268?cb=20260612154623")

mari_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

mari_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

jester_embed = discord.Embed(
        title="Merchant detected !",
        description=f"# > Jester has arrived on the island. 🎭",
        color=discord.Color.purple(),
        timestamp=datetime.datetime.now()
    )

jester_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/5/5e/JesterRender.png/revision/latest/scale-to-width-down/268?cb=20260612154532")

jester_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

jester_embed.set_image(url="https://media.tenor.com/c-EW0prJf-8AAAAm/i-just-hit-the-jackpot-jackpot.webp")

jester_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

rin_embed = discord.Embed(
        title="Merchant detected !",
        description=f"# > Rin has arrived on the island. 🦊",
        color=discord.Color.dark_orange(),
        timestamp=datetime.datetime.now()
    )

rin_embed.set_thumbnail(url="https://static.wikia.nocookie.net/sol-rng/images/a/a7/RinRender.png/revision/latest/scale-to-width-down/268?cb=20260612154656")

rin_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

rin_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

#---------------------------------------------------------------------------------------

normal_embed = discord.Embed(
        title="Biome detected !",
        description=f"# > Biome started - Normal",
        color=discord.Color.from_rgb(180,180,180),
        timestamp=datetime.datetime.now()
    )

normal_embed.set_thumbnail(url="https://media.discordapp.net/attachments/1213813265474265088/1533020752473755718/togif.gif?ex=6a743e55&is=6a72ecd5&hm=6f53cfd2e40e9e39ed358ee4ba6daf9b47776cb94266c88a1d1fa72894805807&=&width=1024&height=922")

normal_embed.add_field(name="", value=f"[ᚙᚙᚏ LINK ᚏᚙᚙ]({serv_url})", inline=True)

normal_embed.set_footer(
        text=f"ED Linux Macro | {version_macro}",
        icon_url=macro_icon
    )

wh_obj = []
for i in webhooks:
    wh_obj.append(discord.SyncWebhook.from_url(i))
biome = sys.argv[1]
emb = windy_embed
print(biome)

if biome.find("NORMAL") != -1:
    emb = normal_embed
elif biome.find("WINDY") != -1:
    emb = windy_embed
elif biome.find("RAINY") != -1:
    emb = rainy_embed
elif biome.find("SNOWY") != -1:
    emb = snowy_embed
elif biome.find("SAND") != -1 or biome.find("STORM") != -1:
    emb = sandtorm_embed
elif biome.find("STARFALL") != -1:
    emb = starfall_embed
elif biome.find("HELL") != -1:
    emb = hell_embed
elif biome.find("HEAVEN") != -1:
    emb = heaven_embed
elif biome.find("CORRUPTION") != -1:
    emb = corruption_embed
elif biome.find("SINGULARITY") != -1:
    emb = singularity_embed
elif biome.find("CYBERSPACE") != -1:
    emb = cyberspace_embed
elif biome.find("DREAMSPACE") != -1:
    emb = dreamspace_embed
elif biome.find("GLITCHED") != -1:
    emb = glitched_embed
elif biome.find("HYPERSPACE") != -1 or biome.find("REALM") != -1:
    emb = realm_embed
elif biome.find("NULL") != -1 or biome.find("EXISTENCE") != -1:
    emb = null_embed
elif biome.find("RED") != -1 or biome.find("MOON") != -1:
    emb = redmoon_embed
elif biome.find("CITADEL") != -1 or biome.find("ORDER") != -1:
    emb = citadel_embed
elif biome.find("BLAZING") != -1:
    emb = blazing_embed
elif biome.find("GRAVEYARD") != -1:
    emb = graveyard_embed
elif biome.find("PUMKIN") != -1:
    emb = pumpkin_embed
elif biome.find("AURORA") != -1:
    emb = aurora_embed
elif biome.find("BLOOD") != -1:
    emb = blood_embed
elif biome.find("EGGLAND") != -1:
    emb = eggland_embed
else:
    emb = unknown_embed

for i in wh_obj:
    i.send(embed=emb)
