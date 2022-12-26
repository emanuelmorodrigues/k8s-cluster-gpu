# Cluster de Inteligência Artificial

## Solução

A solução utilizada para promover um cluster cujo profissionais da área de dados pudessem executar os seus experimentos foi a do [JupyterHub](https://jupyter.org/hub) da Universidade da Califórnia, Berkeley.
- Mais sobre a aplicabilidade da solução: [Choosing the Right JupyterHub Infrastructure](https://data.berkeley.edu/choosing-right-jupyterhub-infrastructure)
- O desafio proposto foi utilizar o JupyterHub juntamente com [Kubernetes](https://kubernetes.io/), mais especificamente o [MicroK8s](https://microk8s.io/) da Canonical.

## Como replicar?

  Passo a passo de como utilizar a solução com as nossas automatizações:

1. Preparação do ambiente na máquina que executará o cluster
    - Com o ansible é possível com poucos passos replicar o ambiente para o uso do cluster. Como executar o ansible: [aqui!](ansible/README.md)
2. Preparação da máquina que irá armazenar os dados do cluster
    - Configuração do NFS: [aqui!](jupyterhub/nfs/README.md)
3. Configuração do JupyterHub
    - Configuração do Storage Class: [aqui!](jupyterhub/storage-config/README.md)
    - Como persistir o arquivo de configuração do JupyterHub? [aqui!](jupyterhub/README.md)
