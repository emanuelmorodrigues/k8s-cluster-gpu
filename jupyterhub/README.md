# Como usar o arquivo de configuração do JupyterHub e persistir as modificações? 

## Configurações
Tópicos:
  - [Proxy](#proxy)
  - [Auth](#auth)
  - [Resources](#resources)
  - [Adicionando um node](#nos_cluster)

*Você deve alterar os campos sugeridos para fazer o deply do JupyterHub*

---

1. <p id="proxy">Proxy</p>
```yaml
  proxy:
  # https:
  #   enabled: true
  #   hosts:
  #     - aiuaba.quixada.ufc.br
  #   letsencrypt:
  #     # Uncomment acmeserver for a test certificate
  #     # acmeServer: "https://acme-staging-v02.api.letsencrypt.org/directory"
  #     # This email gets warnings if auto-renewal fails
  #     contactEmail: manel_mr@alu.ufc.br
  secretToken: # This can be generated with `openssl rand -hex 32`
  service:
    type: LoadBalancer
    labels: {}
    annotations: {}
    nodePorts:
      http: 30080 
      https: 30443
    loadBalancerIP: <to_fill> 
```

As labels `http` e `https` representam as portas web que serão acessíveis para os usuários externos. `loadBalancerIP` representa o IP do load balancer configurado [aqui!](../ansible/roles/master_config/tasks/microk8s-addons.yml), esse será o IP liberado para acesso externo.

---

2. <p id="auth">Admin Users</p>

```yaml
hub:
  config:
    Authenticator:
      admin_users:
        - admin
      check_common_password: true
      open_signup: true
    JupyterHub:
      authenticator_class: nativeauthenticator.NativeAuthenticator

```
A label `admin_users` configura o usuário que terá privilégios de admin. Você pode passar uma lista de usuários administradores. Esses usuários podem fazer o cadastro através da interface do JupyteHub.

---

3. <p id="resources">Resources</p>
```yaml
  singleuser:
  # Use new UI by default as the old UI is being deprecated
  #  defaultUrl: "/lab"
  defaultUrl: "/lab"

  storage:
    type: dynamic
    capacity: 30Gi
    homeMountPath: /home/jovyan/
    dynamic:
      storageClass: nfs-csi
      pvcNameTemplate: claim-{username}{servername}
      volumeNameTemplate: volume-{username}{servername}
      storageAccessModes: [ReadWriteOnce]

  # Default profile, this is what the placeholders will use
  # startTimeout: 1200 # seconds == 20 minutes
  cpu:
    limit: 2
    guarantee: 1
  memory:
    limit: 4G
    guarantee: 2G

  profileList:
  - display_name: "Simple Datascience environment"
    defaultUrl: "/hub/simple"
    description: "Faça seus estudos e execute seus modelos sem GPU."
    default: true
    kubespawner_override:
      image: jupyter/datascience-notebook
      cpu_limit: 4
      cpu_guarantee: 2
      mem_limit: "16G"
      mem_guarantee: "8G"
  - display_name: "Hard Datascience environment"
    defaultUrl: "/hub/hard"
    description: "Faça seus estudos e execute seus modelos com GPU."
    kubespawner_override:
      image: jupyter/tensorflow-notebook
      cpu_limit: 8
      cpu_guarantee: 4
      mem_limit: "32G"
      mem_guarantee: "16G"
      extra_resource_limits:
        nvidia.com/gpu: "1"
```

A label `singleuser` irá definir todos os recursos da instância de um pod. Passando pelo storage, cpu, ram e profiles que são listas de opções de pods que podem ser instanciados a depender da atividade no Jupyterhub.

O comando abaixo irá aplicar as configurações e instanciar os pods necessários para aplicação


```shell
microk8s helm3 install jupyterhub jupyterhub/jupyterhub \
  --namespace jhub \
  --version=2.0.0 \
  --values jupyterhub-config.yaml
```

Para atualizar as configurações, o comando abaixo deve ser digitado no terminal.

```shell
microk8s helm3 upgrade --cleanup-on-fail \
  --install jupyterhub jupyterhub/jupyterhub \
  --version=2.0.0 \
  --namespace jhub \
  --values jupyterhub-config.yaml \
	--reset-values
```

Mais informações sobre o como utilizar o Helm logo abaixo:
https://helm.sh/docs/helm/helm_upgrade/


4. <p id="nos_cluster">Como adicionar um nó no cluster?</p>

Na máquina que hospeda o cluster do MicroK8s, execute os comandos abaixo:
```shell
microk8s add-node
```

O cluster retornará um comando com o token que deve ser executado nos nodes do cluster.

Para mais informações: https://microk8s.io/docs/clustering

