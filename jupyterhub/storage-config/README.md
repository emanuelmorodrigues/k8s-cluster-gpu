# Como utilizar o servidor NFS para a persistência dos dados?

## Criação do Storage Class

No arquivo [sc-nfs.yaml](sc-nfs.yaml) você deve modificar os campos abaixo: 
```python
parameters:
  server: $NFS_SERVER_IP
  share: /srv/nfs/$FOLDER_SHARED
```

A variável `$NFS_SERVER_IP` representa o IP onde o servidor NFS está sendo executado. A `$FOLDER_SHARED` representa o nome da pasta passado durante a configuração do servidor que é a pasta que está sendo compartilhada e onde será persistido os dados.

Para persistir essa configuração execute o comando abaixo:

```python
microk8s kubectl apply -f - < sc-nfs.yaml
```

## (Opcional) Como saber se o passo foi executado sem gerar alguma exceção?

É possível realizar a criação de um PVC(Persistent Volum Claim) para verificar se é possível persistir dado na máquina cujo o servidor NFS está sendo executado

Você precisa executar o comando abaixo que cria um PVC tendo como base o Storage Class criado previamente:

```python
microk8s kubectl apply -f - < pvc-nfs.yaml
```