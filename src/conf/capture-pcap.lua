local arg = {...}

require("utils")

haka.log.info("config", "configuring haka...")

if arg[3] then
	haka.app.install("packet", haka.module.load("packet-pcap", "-i", arg[1], "-o", arg[3]))
else
	haka.app.install("packet", haka.module.load("packet-pcap", "-i", arg[1]))
end

haka.app.install("log", haka.module.load("log-stdout"))

addmodulepath(arg[2])

haka.app.load_configuration(arg[2])

haka.log.info("config", "done\n")