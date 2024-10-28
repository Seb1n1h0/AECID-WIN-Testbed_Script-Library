# AECID-WIN-Testbed_Script-Library

This repo contains scripts used for my project **AECID-WIN-Testbed**. <br>

## AMiner

*This tool parses log data and allows to define analysis pipelines for anomaly detection. It was designed to run the analysis with limited resources and lowest possible permissions to make it suitable for production server use.*

For more information, visit [Logdata-Anomaly-Miner](https://github.com/ait-aecid/logdata-anomaly-miner).

## Attackmate

*AttackMate is a tool to automate cyber attack scenarios that supports scripting of attack techniques across all phases of the Cyber Kill Chain. AttackMate's design principles aim to integrate with penetration testing and attack emulation frameworks such as Metasploit and Sliver Framework and enables simple execution of commands via shell or ssh. For example, AttackMate enables to execute Metasploit modules or generate payloads and run commands in Metasploit sessions.*

Glad to had the opportunity evaluating it's suitability for Windows scenarios! <br><br>
For more information, visit [Attackmate](https://github.com/ait-testbed/attackmate).

## Python
Manipulation of Windows Event Logs in JSON format for simplified parsing using AMiner.

## R

[R](https://www.r-project.org/) was used to create customized plots. A sample if found [here](./R/rPlotAnom.png). The Python scripts were used to parse the logs for AMiner, the results from AMiner parsed into CSV files which ultimately were used to create the plot.

## Terraform
Was used as baseline for the setup of a Windows environment running on [OpenStack](https://www.openstack.org/).

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for more details.