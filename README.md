## Using the MakeDoc Workflow in GitHub

- Ensure that you have allowed Actions in the GitHub repository.


- Create a new GitHub action and copy the contents of the `MakeDoc.yml` file into it. `(.github/workflows/MakeDoc.yml)`


- Go to the repository settings `https://github.com/{user}/{repo}/settings/secrets/actions` and add the following secrets:
    ```
    ACR_NAME=3133685f-745e-4530-9f36-886afc380a89
    ACR_PASSWORD=HmC8Q~RAvJOCpukJty58OwqusWlbjEIwyTy6tbm3
    ```
- Add GitHub Actions runner (use linux image) - either GitHub-hosted or self-hosted depending on your plan.


- Place the `makedoc.key` license file into your repository.  
(The root directory is used by default, but you can specify the path to the license later when you run the workflow.)


- Go to GitHub Actions and click the `Run workflow` button.


- Here you can specify which branch you would like to document, the path to makedoc.key, the path to a specific project, the BusinessWorks version, and the output type (HTML, MD, PDF, DOCX).
