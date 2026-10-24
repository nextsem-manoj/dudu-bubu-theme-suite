# 🤖 Google Play Store Publishing Guide

This guide walks you through compiling and publishing the **Bubu & Dudu Wallpaper & Theme App** to the Google Play Store.

---

## 1. Prerequisites
1. **Google Play Console Account**:
   - Register at [play.google.com/console](https://play.google.com/console) (one-time $25 registration fee).
2. **Android Studio**:
   - Download free from [developer.android.com/studio](https://developer.android.com/studio).
3. **Project Directory**:
   - Located at: `android-app/`

---

## 2. Opening & Building in Android Studio

1. Open **Android Studio**.
2. Click **Open** and select the folder:
   `C:\Users\Manoj\.gemini\antigravity-ide\scratch\dudu-bubu-theme-suite\android-app`
3. Wait for Gradle sync to complete.

### Generate Signed Android App Bundle (.aab)
1. In Android Studio top menu, click **Build** -> **Generate Signed Bundle / APK...**
2. Choose **Android App Bundle** and click **Next**.
3. **Key store path**: Click **Create new...** to create your release keystore (save it securely, e.g., `bubu_dudu_release.jks`).
4. Enter password, alias name, and validity (25+ years).
5. Choose destination folder, select **release**, check **V2 (Full APK Signature)**, and click **Finish**.
6. Your production `.aab` file will be generated in `app/release/app-release.aab`.

---

## 3. Play Console Submission Walkthrough

1. **Create App in Play Console**:
   - Go to [Google Play Console](https://play.google.com/console).
   - Click **Create app**.
   - **App name:** `Bubu & Dudu Wallpapers & Themes`
   - **Default language:** English (US)
   - **App or game:** `App`
   - **Free or Paid:** `Free`
   - Accept declarations and click **Create app**.

2. **Main Store Listing**:
   - **Short description:**
     > Adorable HD Bubu & Dudu kawaii wallpapers for lock screen & home screen!
   - **Full description:**
     > Decorate your phone with the most adorable Bubu and Dudu kawaii wallpapers!
     > 
     > ✨ Features:
     > - High Definition (HD & 4K) cute wallpapers featuring Bubu the panda and Dudu the bear
     > - 1-Click apply to Home Screen, Lock Screen, or Both
     > - Works offline without internet required
     > - Optimized for battery and display resolution
     > - Soft pastel aesthetic aesthetic stickers and scenes
   - **App icon (512x512 PNG):**
     Upload `store-assets/icon_512x512.png`
   - **Feature graphic (1024x500 JPEG/PNG):**
     Upload `store-assets/feature_graphic_1024x500.jpg`
   - **Phone Screenshots:**
     Upload `mobile-wallpapers/mobile_01_sweet_friends.jpg` and `mobile-wallpapers/mobile_02_selfie_time.jpg`.

3. **App Content & Declarations**:
   - **Privacy Policy:** Provide the URL to your hosted privacy policy (a ready-to-use template is provided in `PRIVACY_POLICY.md`).
   - **Ads:** Select "No, my app does not contain ads" (or Yes if you add AdMob).
   - **App Access:** "All functionality is available without special access".
   - **Content Ratings:** Complete questionnaire (Select Utility / Personalization — rating will be Everyone 3+).
   - **Target Audience:** Select Ages 13+ (or Families if you opt into Designed for Families).
   - **Data Safety:** Select "Does not collect or share any user data".

4. **Production Release**:
   - Under **Release** -> **Production**, click **Create new release**.
   - Upload your signed `app-release.aab` bundle.
   - Enter release notes: `Initial release: Official Bubu & Dudu Kawaii Theme Pack`.
   - Click **Review release** and **Start rollout to Production**!
