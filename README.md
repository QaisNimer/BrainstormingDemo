# Flutter Project – Team Setup Guide (English + Arabic)

## ENGLISH

Welcome to the organized Flutter branch! This guide will help each team member connect their local project to GitHub **without losing any local work**, and contribute properly using individual branches.

---

### General Notes
- **DO NOT push directly to the `main` or `rand-branch` branch.**
- Each developer must work on their **own branch**.
- All changes will be merged after review via **Pull Requests**.

---

### Initial Setup (If You Already Have Local Work)

#### 1. Open Terminal in your project's root folder.

#### 2. Check if Git is initialized:
```bash
git status
```

If not initialized, run:
```bash
git init
```

#### 3. Add the GitHub remote repository:
```bash
git remote add origin https://github.com/widadamjad/Brainstorming.git
```

#### 4. Fetch all branches from the remote:
```bash
git fetch origin
```

#### 5. Create and switch to your personal branch:

**For Duha:**
```bash
git checkout -b duha-branch
```

**For Alaa:**
```bash
git checkout -b alaa-branch
```

#### 6. Stage and commit your local changes:
```bash
git add .
git commit -m "Initial commit with local work"
```

#### 7. Push your branch to GitHub:
```bash
git push origin duha-branch   # if you're Duha
git push origin alaa-branch   # if you're Alaa
```

---

### Continuing Work

- Always work in your own branch.
- Commit and push frequently.
- When your task is complete, open a **Pull Request** to `rand-branch` for review.

---

### Pulling the latest updates

Before starting new work:
```bash
git checkout duha-branch   # or alaa-branch
git pull origin duha-branch
```

---

## ARABIC

### تعليمات ربط المشروع المحلي مع GitHub بدون ما يضيع الشغل

---

### ملاحظات عامة:
- **ممنوع أي حدا يرفع شغله على `main` أو `clean_flutter_project`.**
- كل واحد يشتغل بفرع خاص فيه.
- الدمج بيصير بعد مراجعة Pull Request.

---

### الخطوات:

#### ١. افتح التيرمنال داخل مجلد مشروعك.

#### ٢. تأكد إذا المشروع مربوط بـ git:
```bash
git status
```

لو مش مربوط:
```bash
git init
```

#### ٣. اربط المشروع مع مستودع GitHub:
```bash
git remote add origin https://github.com/widadamjad/Brainstorming.git
```

#### ٤. اسحب كل الفروع من GitHub:
```bash
git fetch origin
```

#### ٥. اعمل فرع خاص فيك:

**Duha:**
```bash
git checkout -b duha-branch
```

**Alaa:**
```bash
git checkout -b alaa-branch
```

#### ٦. اعمل commit للشغل:
```bash
git add .
git commit -m "رفع شغلي المحلي"
```

#### ٧. ارفع الفرع على GitHub:
```bash
git push origin duha-branch
```

أو:

```bash
git push origin alaa-branch
```

---

### بعدين كل واحد يشتغل بفرعه، ولما يخلص يفتح Pull Request للفرع الأساسي `rand-branch`.
