# Configurando repositórios pelo microk8s helm3

## Por que executar manualmente?

 - O Ansible funciona bem com o Helm quando instalado direto no host, mas não é compatível com o Helm como addon no microk8s.

## Como executar?

- Depois de rodar o Playbook do Ansible basta executar os seguintes scripts:
1.
```shell
./helm_nfs.sh
```

2.
```shell
./helm_jupyter.sh 
```

Executar nesta ordem é importante porque antes de instalar o Jupyterhub é necessário que todos os recursos essenciais devam ser configurados previamente.
