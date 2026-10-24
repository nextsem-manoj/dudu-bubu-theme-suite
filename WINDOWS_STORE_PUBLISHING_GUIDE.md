# 🪟 Windows Store (Microsoft Store) Publishing Guide

This guide walks you step-by-step through publishing the **Bubu & Dudu Kawaii Theme Pack** to the Microsoft Store.

---

## 1. Prerequisites
1. **Microsoft Developer Account**:
   - Register at [Microsoft Partner Center](https://partner.microsoft.com/dashboard).
   - Individual accounts have a one-time registration fee (~$19 USD) with no recurring fees.
2. **Package Folder**:
   - Located at: `windows-store-package/`

---

## 2. Package Identity Setup
Open `windows-store-package/AppxManifest.xml` and update the Identity fields to match your Partner Center reservation:

```xml
<Identity Name="YourPackageReservedName"
          Publisher="CN=Your-Publisher-ID-From-Partner-Center"
          Version="1.0.0.0"
          ProcessorArchitecture="neutral" />
```
> **Tip:** You find your exact `Publisher` string in **Partner Center** -> **Account settings** -> **Developer info**.

---

## 3. Packaging into MSIX / APPX
Microsoft Store accepts `.msix` or `.appxupload` files.

### Method A: Using MSIX Packaging Tool (Free from Microsoft Store)
1. Download the **MSIX Packaging Tool** directly from the Microsoft Store.
2. Launch it and choose **Package an existing folder**.
3. Select the `windows-store-package` folder as the root directory.
4. It will validate the `AppxManifest.xml`, bundle the `Assets/` and `Theme/` folders, and generate `BubuAndDuduTheme.msix`.

### Method B: Using MakeAppx (Windows SDK)
If you have the Windows 10/11 SDK installed:
```powershell
MakeAppx.exe pack /d "C:\Users\Manoj\.gemini\antigravity-ide\scratch\dudu-bubu-theme-suite\windows-store-package" /p "BubuAndDuduTheme.msix"
```

---

## 4. Microsoft Store Submission Steps

1. **Log in to Partner Center**:
   - Go to [partner.microsoft.com/dashboard/apps/overview](https://partner.microsoft.com/dashboard/apps/overview).
   - Click **Create a new app** and reserve the name: `Bubu and Dudu Theme Pack`.

2. **Packages**:
   - Drag and drop your compiled `BubuAndDuduTheme.msix` into the upload zone.

3. **Store Listing Details**:
   - **Product Title:** `Bubu & Dudu Kawaii Theme Pack`
   - **Short Description:** Adorable kawaii theme featuring Bubu the panda and Dudu the bear with 4K wallpapers and pastel accent colors.
   - **Full Description:**
     > Bring the heartwarming adventures of Bubu & Dudu to your Windows PC! This official kawaii theme pack includes high-resolution desktop wallpapers (Picnic, Movie Night, and Sticker Montage) with automatic wallpaper slideshow rotation and soft pastel blush accent highlights.
   - **Category:** `Personalization` -> `Themes`
   - **Search Terms / Keywords:** `Bubu`, `Dudu`, `Bubu and Dudu`, `Kawaii`, `Cute Theme`, `Panda Bear`, `Aesthetic Wallpaper`

4. **Visual Assets Upload**:
   - **App Tile Icon:** Upload `store-assets/icon_512x512.png`
   - **Store Promotional Header:** Upload `store-assets/feature_graphic_1024x500.jpg`
   - **Screenshots:** Capture full desktop screenshots or upload the wallpaper previews from `windows-theme/wallpapers/`.

5. **Age Rating & Pricing**:
   - Age Rating: Select "All Ages / General (PEGI 3 / ESRB Everyone)".
   - Pricing: Choose **Free** (or a price tier of your choice).

6. **Submit for Certification**:
   - Click **Submit to the Store**.
   - Review typically takes 24 to 72 hours.
