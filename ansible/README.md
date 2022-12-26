# Como replicar ambiente para o Cluster do JupyterHub?

1. Copiar a secret key do seu host atual para o servidor onde as instalações serão feitas. (*)

     ```python
     ssh-copy-id $SERVER_PORT $USERNAME@$SERVER_DOMAIN
     ```

2. Configurar um arquivo que irá conter as informações das máquinas:
     - Criar um arquivo com o nome `inventory` no diretório raiz com a estrutura semelhante ao [inventory-model](inventory-model)
3. Executar o comando abaixo que irá executar as tasks na ordem pré-configurada no arquivo [main.yml](roles/master_config/tasks/main.yml):
   ```python
   ansible-playbook setup-jupyterhub.yml -i inventory 
   ```

(*) Este passo não é recomendado para um ambiente em produção. As chaves ssh devem ser criadas para cada host e guardadas em local apropriado e seguro.
  