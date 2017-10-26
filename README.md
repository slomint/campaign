# campaign
campaign is a series of scripts written for the purpose of improving the coordination of assessing a local network for vulnerabilities from the reconnaissance process all the way through post-exploitation. It was written primarily for usage in the attack-and-defend capture-the-flag (CTF) security competition Panoply. 

Panoply is a network security competition hosted by The Center for Infrastructure Assurance and Security (CIAS) where teams of students compete for possession of vulnerable machines utilizing offensive security techniques. Additionally, students must defend those same machines from other teams. More information can be found at http://www.cyberpanoply.com/.

Included are several scripts, mostly written in bash and one of which that is written in Python. In the '1-recon' folder is a series of bash scripts that use nmap to scan for ports 1524, 22, and 445 and generate lists of hosts in grep-able output. Each list has a corresponding additional bash script, located in '2-generate', which will then create a metasploit resource script using the list of hosts. The metasploit resource scripts that are generated allow for usage of the ssh_login auxiliary module and ms08_067_netapi and ms17_010_eternal_blue exploit modules on multiple hosts.

The programs in this repository should only be used for educational purposes and in a safe setting such as in a local CTF or offensive security competition where their usage would be allowed.
