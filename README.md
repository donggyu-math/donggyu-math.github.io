# Donggyu Kim Homepage

Personal homepage for `https://donggyu-math.github.io/`, built with Hugo and deployed with GitHub Pages Actions.

## Local preview

Install Hugo Extended, then run:

```bash
hugo server
```

The repository tracks Hugo source files only. The GitHub Actions workflow builds `public/` and deploys it automatically after changes are pushed to the `main` branch.

## CV update

The homepage links to `static/files/cv.pdf`. After exporting a fresh CV to:

```bash
/Users/family/Documents/workspace/cv/cv.pdf
```

update the website copy and run a local Hugo build check when Hugo is available:

```bash
./scripts/update-cv.sh
```

Then publish it:

```bash
git add static/files/cv.pdf
git commit -m "Update CV"
git push
```

GitHub Actions will deploy the updated CV automatically. To use a different PDF source once:

```bash
./scripts/update-cv.sh /path/to/cv.pdf
```
