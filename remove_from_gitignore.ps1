git rm --cached $(git ls-files -i -X .gitignore)
git commit -m "Remove stuff from gitignore"
git push