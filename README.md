# 🚀 Flutter Project – Team Setup Guide (RandFoodtek)

Welcome to the `rand-new_branch` organized branch! This guide will help each team member connect their local project to GitHub **without losing any local work**, and contribute properly using individual branches.

---

## 🔹 General Notes

- 🚫 **DO NOT** push directly to the `main` or `rand-new_branch` branch.
- 👤 Each developer must work on their **own branch**.
- ✅ All changes will be merged after review via **Pull Requests**.

---

## 🔧 Initial Setup (If You Already Have Local Work)

1. Open Terminal in your project's root folder.

2. Check if Git is initialized:
   ```bash
   git status
   ```

   If not, run:
   ```bash
   git init
   ```

3. Add the GitHub remote:
   ```bash
   git remote add origin https://github.com/QaisNimer/BrainstormingDemo.git
   ```

4. Fetch all branches:
   ```bash
   git fetch origin
   ```

5. Create & switch to your personal branch:

   **For Duha:**
   ```bash
   git checkout -b duha-branch
   ```

   **For Alaa:**
   ```bash
   git checkout -b alaa-branch
   ```

6. Stage and commit your local work:
   ```bash
   git add .
   git commit -m "Initial commit with local work"
   ```

7. Push your branch:
   ```bash
   git push origin duha-branch   # if you're Duha
   git push origin alaa-branch   # if you're Alaa
   ```

---

## 📌 Continuing Work

- Work only in **your own branch**
- Commit and push frequently
- When done, open a **Pull Request** to `rand-new_branch` for review

---

## 🔄 Pull the Latest Updates

Before starting work:
```bash
git checkout duha-branch   # or alaa-branch
git pull origin duha-branch
```

---

## 🔁 Creating a Pull Request & Merge

1. Go to: [GitHub Repo](https://github.com/QaisNimer/BrainstormingDemo)

2. Click **Compare & pull request** when your branch has changes

3. Make sure:
   - **Base branch:** `randfoodtek_branch`
   - **Compare branch:** your personal branch (e.g., `duha-branch` or `alaa-branch`)

4. Add a short description of your changes

5. Click **Create pull request**

6. After approval, your branch will be merged into `rand-new_branch`

---

🎉 **Happy Coding!**

