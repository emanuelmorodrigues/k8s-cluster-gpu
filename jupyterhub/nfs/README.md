# Como configurar o servidor NFS?

1. Na máquina que será o servidor, execute o script: [`nfs.sh`](nfs.sh)
  - O comando abaixo que executa o script é responsável por criar uma pasta que irá ser acessível de forma externa por um cliente [nfs](https://www.ibm.com/docs/pt-br/flashsystem-v7000u/1.5.2?topic=system-connecting-using-nfs-from-microsoft-windows-client).
    ```
    ./nfs.sh --folder $FOLDER_NAME
    ```
  - Após a execução o path `/srv/nfs/$FOLDER_NAME` será acessível.

  - Para mais informações, seguir o tutorial do link abaixo
  https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04-pt
  