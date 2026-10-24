package com.kawaii.bubududutheme

import android.app.WallpaperManager
import android.graphics.BitmapFactory
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.button.MaterialButton
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

data class WallpaperItem(
    val title: String,
    val category: String,
    val resId: Int
)

class MainActivity : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private val wallpaperList = listOf(
        // Mobile Wallpapers (9:16)
        WallpaperItem("Sweet Friends Forever", "Mobile 9:16", R.drawable.wallpaper_mobile_friends),
        WallpaperItem("Cute Selfie Time", "Mobile 9:16", R.drawable.wallpaper_mobile_selfie),
        WallpaperItem("Starry Bedtime Cuddle", "Mobile 9:16", R.drawable.wallpaper_bedtime),
        WallpaperItem("Froggy Raincoat Friends", "Mobile 9:16", R.drawable.wallpaper_froghats),
        
        // Desktop / Tablet Wallpapers (16:9)
        WallpaperItem("Strawberry Shortcake Cafe", "Widescreen 16:9", R.drawable.wallpaper_strawberries),
        WallpaperItem("Kitty Headset Gaming", "Widescreen 16:9", R.drawable.wallpaper_gaming),
        WallpaperItem("Picnic & Boba Tea", "Widescreen 16:9", R.drawable.wallpaper_picnic),
        WallpaperItem("Cozy Movie Night", "Widescreen 16:9", R.drawable.wallpaper_movie_night),
        WallpaperItem("Bubu & Dudu Sticker Collage", "Full Montage 16:9", R.drawable.wallpaper_sticker_collage)
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        recyclerView = findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this)
        recyclerView.adapter = WallpaperAdapter(wallpaperList) { wallpaper ->
            showApplyDialog(wallpaper)
        }
    }

    private fun showApplyDialog(wallpaper: WallpaperItem) {
        val options = arrayOf(
            getString(R.string.set_home),
            getString(R.string.set_lock),
            getString(R.string.set_both)
        )

        AlertDialog.Builder(this)
            .setTitle(wallpaper.title)
            .setItems(options) { _, which ->
                val flag = when (which) {
                    0 -> WallpaperManager.FLAG_SYSTEM
                    1 -> WallpaperManager.FLAG_LOCK
                    else -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
                }
                applyWallpaper(wallpaper.resId, flag)
            }
            .setNegativeButton("Cancel", null)
            .show()
    }

    private fun applyWallpaper(resId: Int, flag: Int) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val bitmap = BitmapFactory.decodeResource(resources, resId)
                val wallpaperManager = WallpaperManager.getInstance(applicationContext)

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    wallpaperManager.setBitmap(bitmap, null, true, flag)
                } else {
                    wallpaperManager.setBitmap(bitmap)
                }

                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, getString(R.string.wallpaper_applied), Toast.LENGTH_SHORT).show()
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, "Failed to set wallpaper: ${e.message}", Toast.LENGTH_LONG).show()
                }
            }
        }
    }
}

class WallpaperAdapter(
    private val items: List<WallpaperItem>,
    private val onItemClick: (WallpaperItem) -> Unit
) : RecyclerView.Adapter<WallpaperAdapter.ViewHolder>() {

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val ivThumbnail: ImageView = view.findViewById(R.id.ivThumbnail)
        val tvTitle: TextView = view.findViewById(R.id.tvTitle)
        val tvCategory: TextView = view.findViewById(R.id.tvCategory)
        val btnApply: MaterialButton = view.findViewById(R.id.btnApply)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_wallpaper, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = items[position]
        holder.tvTitle.text = item.title
        holder.tvCategory.text = item.category
        holder.ivThumbnail.setImageResource(item.resId)

        holder.btnApply.setOnClickListener { onItemClick(item) }
        holder.itemView.setOnClickListener { onItemClick(item) }
    }

    override fun getItemCount(): Int = items.size
}
