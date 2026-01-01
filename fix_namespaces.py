# mkdir -p packages/android_intent
# cp -r ~/.pub-cache/hosted/pub.dev/android_intent-2.0.2/* packages/android_intent/

import os
import re

# brew install python
# python3 fix_namespaces.py



# add namespace
def find_and_fix_gradle_files(root_dir):
    count = 0
    for dirpath, dirnames, filenames in os.walk(root_dir):
        if "android" in dirpath and "build.gradle" in filenames:
            file_path = os.path.join(dirpath, "build.gradle")
            with open(file_path, "r", encoding="utf-8") as file:
                lines = file.readlines()

            if any("namespace" in line for line in lines):
                continue  # skip if namespace already exists

            for i, line in enumerate(lines):
                if "android {" in line:
                    package_hint = dirpath.split(os.sep)[-3].replace("-", "_")
                    lines.insert(i + 1, f'    namespace "com.generated.{package_hint}"\n')
                    with open(file_path, "w", encoding="utf-8") as file:
                        file.writelines(lines)
                    print(f"✅ Added namespace to: {file_path}")
                    count += 1
                    break
    print(f"\n✅ Done. {count} file(s) updated.")

# شغّل على مجلد .pub-cache و packages المحلي
find_and_fix_gradle_files(os.path.expanduser("~/.pub-cache"))
find_and_fix_gradle_files("./packages")



# remove package name from AndroidManifest.xml after add namespace
# مسار pub-cache على جهازك
pub_cache_path = os.path.expanduser("~/.pub-cache/hosted/pub.dev")

# مر على كل الباكدجات في pub-cache
for root, dirs, files in os.walk(pub_cache_path):
    for file in files:
        if file == "AndroidManifest.xml":
            manifest_path = os.path.join(root, file)

            # اقرأ المحتوى
            with open(manifest_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # لو فيه package في وسم <manifest>، شيله
            new_content = re.sub(r'<manifest[^>]*\s+package="[^"]+"([^>]*)>', r'<manifest\1>', content)

            # لو تم تغيير المحتوى، احفظ التغيير
            if content != new_content:
                print(f"Fixing: {manifest_path}")
                with open(manifest_path, 'w', encoding='utf-8') as f:
                    f.write(new_content)





pub_cache_path = os.path.expanduser("~/.pub-cache/hosted/pub.dev")

for package in os.listdir(pub_cache_path):
    android_manifest_path = os.path.join(pub_cache_path, package, "android/src/main/AndroidManifest.xml")

    if os.path.exists(android_manifest_path):
        with open(android_manifest_path, "r", encoding="utf-8") as f:
            content = f.read()

        original_content = content

        # Remove any package="..." from <manifest>
        content = re.sub(r'<manifest[^>]*\s+package="[^"]+"', lambda m: re.sub(r'\s+package="[^"]+"', '', m.group()), content)

        # Add xmlns:android if missing
        if '<manifest' in content and 'xmlns:android=' not in content:
            content = content.replace('<manifest', '<manifest xmlns:android="http://schemas.android.com/apk/res/android"', 1)

        # Only write if content was changed
        if content != original_content:
            with open(android_manifest_path, "w", encoding="utf-8") as f:
                f.write(content)
            print(f"✅ Fixed: {android_manifest_path}")
        else:
            print(f"⏭️ Already OK: {android_manifest_path}")





# مسار pub-cache عندك (ممكن تغييره لو عندك مسار مختلف)
pub_cache_path = os.path.expanduser("~/.pub-cache/hosted/pub.dev")

# نبدأ نمشي على كل الملفات داخل pub-cache
for root, dirs, files in os.walk(pub_cache_path):
    for file in files:
        if file == "AndroidManifest.xml":
            file_path = os.path.join(root, file)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            if "tools:overrideLibrary" in content and 'xmlns:tools=' not in content:
                print(f"🛠️ Fixing: {file_path}")

                # أضف xmlns:tools داخل وسم <manifest>
                fixed_content = re.sub(
                    r"<manifest([^>]*?)>",
                    r'<manifest\1 xmlns:tools="http://schemas.android.com/tools">',
                    content,
                    count=1
                )

                # اكتب التعديل
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(fixed_content)

print("✅ Done fixing AndroidManifest.xml files.")





pub_cache_path = os.path.expanduser("~/.pub-cache/hosted/pub.dev")

for root, dirs, files in os.walk(pub_cache_path):
    for file in files:
        if file == "AndroidManifest.xml":
            file_path = os.path.join(root, file)
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

            # Skip لو مش محتاج تعديل
            if "tools:" in content and 'xmlns:tools=' not in content:
                print(f"🔧 Fixing: {file_path}")
                fixed = re.sub(
                    r"<manifest([^>]*?)>",
                    r'<manifest\1 xmlns:tools="http://schemas.android.com/tools">',
                    content,
                    count=1
                )
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(fixed)

print("✅ Finished fixing all AndroidManifest.xml files.")