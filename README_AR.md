[Français](README.md) | **[العربية](README_AR.md)**

<div dir="rtl">

<h1>nvim-config</h1>

إعداداتي الخاصة لـ Neovim للبرمجة بلغة C/C++ في مجال الحوسبة عالية الأداء (OpenMP و MPI و CMake) وللغة Python أيضًا. يتم التثبيت على نظام Ubuntu أو Fedora بأمر واحد.

<h2>المحتوى</h2>

| الملف | الدور |
|---|---|
| `init.vim` | إعدادات Neovim: الإضافات والخيارات والاختصارات |
| `coc-settings.json` | إعدادات clangd للغة C/C++ مع دعم `mpicc` و `mpicxx` |
| `install.sh` | يثبّت المتطلبات والخط والإضافات ثم يربط الإعدادات |

<h2>التثبيت</h2>

</div>

```bash
git clone git@github.com:TON_USER/nvim-config.git ~/devTools/nvim
~/devTools/nvim/install.sh
```

<div dir="rtl">

بعد ذلك، اختر الخط **JetBrainsMono Nerd Font** من تفضيلات الطرفية.

ينشئ `install.sh` رابطًا يجعل `~/.config/nvim` يشير إلى `~/devTools/nvim` تلقائيًا. لا تُحذف الإعدادات الموجودة مسبقًا، بل تُحفظ باسم `~/.config/nvim.backup.*` كنسخة احتياطية.

**المتطلبات:** إصدار Neovim 0.8 أو أحدث، وإصدار Node.js 16.18 أو أحدث. يتحقق السكربت من الإصدارات ويعرض تحذيرًا إذا كانت قديمة.

<h2>تخطيط الشاشة</h2>

</div>

```
┌──────────┬───────────────────┬──────────────┐
│ NERDTree │       code        │   terminal   │
│ Space e  │                   │     F12      │
└──────────┴───────────────────┴──────────────┘
```

<div dir="rtl">

يفتح الأمر `nvim .` مباشرةً NERDTree على اليسار.

<h2>الاختصارات الرئيسية</h2>

مفتاح leader هو مفتاح **المسافة**.

| الاختصار | الوظيفة |
|---|---|
| `jk` | الخروج من وضع الإدخال (مثل `Esc`) |
| `Ctrl+h/j/k/l` | التنقل بين النوافذ (يعمل أيضًا من الطرفية) |
| `Space e` | فتح/إغلاق NERDTree |
| `F12` | فتح/إغلاق الطرفية |
| `Space ff` / `fg` / `fb` | البحث عن ملف / نص / buffer باستخدام fzf |
| `Space m` | ترجمة البرنامج (CMake أو Make أو الملف وحده) |
| `Space n` / `Space p` | خطأ الترجمة التالي / السابق |
| `F5` | ترجمة وتشغيل (C/C++) أو تشغيل (Python) |
| `gd` / `gr` / `K` | التعريف / المراجع / التوثيق |
| `Space rn` | إعادة تسمية رمز |
| `Space ca` | تصحيح تلقائي (code action) |
| `Space h` | التبديل بين ملف `.c`/`.cpp` وملف `.h` |
| `Space dl` | قائمة التشخيصات |
| `Space u` / `Space t` | سجل التراجع / بنية الشيفرة |
| `Space gs` | حالة Git عبر fugitive |

<h2>ملف compile_commands.json لـ clangd</h2>

لكي يفهم clangd المشروع (الملفات المضمّنة وخيارات الترجمة)، يجب وجود هذا الملف في جذر المشروع:

</div>

```bash
# CMake
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
ln -s build/compile_commands.json .

# Makefile
bear -- make
```

<div dir="rtl">

<h2>الإضافات</h2>

vim-plug · coc.nvim · NERDTree · fzf · vim-floaterm · vim-airline · vim-fugitive · tagbar · undotree · vim-surround · vim-commentary · vim-move · onedark · gruvbox · vim-devicons

<h2>شكر وتقدير</h2>

- شكرًا لـ [freeCodeCamp](https://github.com/freeCodeCamp) على مواردها التعليمية.
- شكرًا لـ [NeuralNine](https://github.com/NeuralNine) على درسه حول Neovim الذي كان أساس هذه الإعدادات.

</div>
