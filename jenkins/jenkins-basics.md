
# Jenkins Basics

- [Jenkins Basics](#jenkins-basics)
  - [Creating a New Project](#creating-a-new-project)
  - [Linking Two Projects Together](#linking-two-projects-together)

## Creating a New Project

1. **Select New Item**:
   - In Jenkins, navigate to the dashboard and select **New Item**.

2. **Enter a Name for the Project**:
   - Provide a name for your project.

3. **Select Freestyle Project**:
   - Choose **Freestyle project** and click **OK**.

4. **Enable Discard Old Builds**:
   - Enable **Discard old builds** and set it to a maximum of **5**. This means that up to 5 build histories are kept in the record at a time.

5. **Add a Build Step**:
   - Scroll down to the **Build** section and click **Add build step**.

6. **Select Execute Shell**:
   - Choose **Execute shell** and in the input your script.

7. **Select Build Now**:
   - On the right side of the screen, select **Build Now**.

8. **View Build Details**:
   - Once the build is complete, click the build number or date and time to get more details.

9. **View Console Output**:
   - Select **Console Output** to see the output of your script. It provides detailed information about the system's kernel and operating system.

## Linking Two Projects Together

1. **Go to the Job You Want to Start With**:
   - Navigate to the job you want to start with.

2. **Go to Configure**:
   - Select **Configure**.

3. **Scroll Down to Post-Build Actions**:
   - Scroll down to the **Post-Build Actions** section.

4. **Select Projects to Build**:
   - Choose **Projects to build**.

5. **Input the Name of the Project to Trigger**:
   - Input the name of the project you want to trigger after this first job has run successfully.

6. **Click Save**:
   - Click **Save** to apply the changes.

7. **Select Build Now**:
   - Select **Build Now** and wait for the build to finish running.

8. **View Build History**:
   - Select the build under the history. You'll see it has run both jobs, but you can only view the output for the second build if you're in that build's section.

9. **Navigate Between Projects**:
   - You can select the hyperlink to go straight to the other project.
