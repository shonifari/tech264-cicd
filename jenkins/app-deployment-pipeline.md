# How to deploy Sparta App with a Jenkins CICD pipeline

- [How to deploy Sparta App with a Jenkins CICD pipeline](#how-to-deploy-sparta-app-with-a-jenkins-cicd-pipeline)
  - [Job 1 - Testing](#job-1---testing)
    - [Enable GitHub Project](#enable-github-project)
    - [Source Code Management](#source-code-management)
    - [Build Environment](#build-environment)
    - [Build Steps](#build-steps)
    - [Run the pipeline](#run-the-pipeline)
  - [Job 2 - Merge](#job-2---merge)
    - [Configure the Project](#configure-the-project)
  - [Job 3 - Deploy](#job-3---deploy)
    - [Configuration](#configuration)

---
![Pipeline](<../images/tech264 (9).png>)

## Job 1 - Testing

Follow the steps to [create a new project](jenkins-basics.md#creating-a-new-project)

### Enable GitHub Project

- Enable **GitHub project**.
- Enter the **HTTPS link** for the repository you wish to link.
- >> **Make sure you don't include `.git` and end your url with `/`**

   ![Project url](<../images/Screenshot 2024-10-18 145255.png>)

### Source Code Management

1. **Select Git**:
   - Choose **Git** and enter your **SSH** repository link.

2. **Add Your Credentials**:
   - For the **Kind** section, select **SSH Username with private key**.
   - In **ID**, name it the same as the key.
   - In **Description**, write what the key is going to be used for.
   - In the **Username** section, paste the **ID** we just used.
   - Under **Private Key**, enable **Enter directly** and input your private key.

3. **Click Add**:
   - Click **Add** to save the credentials.

4. **Select the Key**:
   - Under the **Credentials** dropdown, select the key you've added.

      ![SSH Git connection](<../images/Screenshot 2024-10-18 150139.png>)

5. **Branches to Build**:
   - Change it to `*/main`. Later, this can be changed to `dev`.

      ![Source branch](<../images/Screenshot 2024-10-18 150715.png>)

### Build Environment

1. **Enable Provide Node and npm bin/folder to PATH**:
   - Specify **NodeJS version 20**. This allows you to run Node.js and npm commands.

      ![alt text](<../images/Screenshot 2024-10-18 150945.png>)

### Build Steps

1. **Add an Execute Shell Build Step**:
   - Insert the code from [Job 1 script](../scripts/job1.sh):

     ```bash
     cd app
     npm install
     npm test
     ```

2. **Click Save**:
   - Click **Save** to return to the job screen.
   ![alt text](<../images/Screenshot 2024-10-18 151104.png>)

### Run the pipeline

1. **Select Build Now**
2. **View Build History**:
   - You can view the job by clicking the link to it under **Build History**.

3. **View Console Output**:
   - Click **Console Output** to see the build process in real time.

---

## Job 2 - Merge

### Configure the Project

1. **Create a New Project**:
   - Follow the steps to [create a new project](jenkins-basics.md#creating-a-new-project)
, including providing the [Github repository](#source-code-management) and selecting your **SSH** key.

2. **Merge code**
   There are two different options to merge branches:

   1. **Add a Build Step**:
      - Add a build step with the following commands:

         ```bash
         git switch main            # Switch to the Main Branch
         git merge origin/dev       # Merge Changes from `dev` Branch
         git push origin main       # Push Changes to GitHub
         ```

   2. **Add Git Publisher (Prefered standard)**

      ![alt text](<../images/Screenshot 2024-10-21 104129.png>)

      - **Publish Only id Build Succeeds**: Avoid merging broken code
      - **Merge Results**: Check to merge the branches
      - **Branches**:
        - **Branch to push**: *'main'*
        - **Target remote name**: *'origin'*

By following these steps, you can effectively merge changes from the `dev` branch into the `main` branch and push the updated `main` branch to your GitHub repository.

---

## Job 3 - Deploy

### Configuration

1. **Create a New Project**:

   Follow the steps to [create a new project](jenkins-basics.md#creating-a-new-project)
, including providing the [Github repository](#source-code-management) and selecting your **SSH** key.

2. **SSH Credentials**

   We need to provide Jenkins with the **SSH credentials** to access the **EC2 instance**. We can use the **SSH Agent** plugin.

   ![alt text](<../images/Screenshot 2024-10-21 140351.png>)

3. **Bash Shell Script**

   Use script in [Job 3 Script](../scripts/job3.sh)

      ```bash
      #!/bin/bash
      EC2_USER=ubuntu
      EC2_IP="3.250.154.185"

      # Copy the app folder to the home folder in EC2
      rsync -avz  -e "ssh -o StrictHostKeyChecking=no" app $EC2_USER@$EC2_IP:~/

      ssh $EC2_USER@$EC2_IP << EOF
      cd app
      pm2 stop all
      npm install
      pm2 start app.js
      EOF

      ```
