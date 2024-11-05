## Using the MakeDoc Workflow in GitHub

- Ensure that you have enabled Actions in the GitHub repository.

- Copy the actions from this repository `.github/workflows/*`  or create a new GitHub Action and copy the contents of the `MakeDoc-manual.yml` or `MakeDoc-on-push.yml` file into it.  You can use both or choose only one depending on whether you want to run makedoc manually or on-push.

- Go to the repository settings `https://github.com/{user}/{repo}/settings/secrets/actions` and add the following secrets:
    ```
    ACR_NAME=3133685f-745e-4530-9f36-886afc380a89
    ACR_PASSWORD=HmC8Q~RAvJOCpukJty58OwqusWlbjEIwyTy6tbm3
    ```
- Add GitHub Actions runner (use a Linux image) - either GitHub-hosted or self-hosted depending on your plan. (the runner must be able to run Docker)

- Place the `makedoc.key` license file into your repository.  
(The root directory is used by default, but you can also specify the path to the license later when you run the workflow.)

- Copy the `makedoc` directory to your repository including whole workspace directory (`ws`) and transformation scripts (`transform.sh`, `transform_RA.sh`), 
<b>omit `storage` directory</b> - it will be created automatically

- Make sure your BW project is included 

- Go to GitHub Actions and click the `Run workflow` button.

- Here you can specify which branch you would like to document, the path to makedoc.key, the path to a specific project, the BusinessWorks version, and the output format (HTML, MD, PDF, DOCX).

- In case you want to generate MakeDoc documentation automatically on push, you should check the workflow configuration (`.github/workflows/MakeDoc-on-push.yml`) - select correct BW version, output format and filters 

