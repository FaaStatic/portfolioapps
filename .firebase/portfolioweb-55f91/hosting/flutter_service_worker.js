'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1151e98cf573fed171dd37e75b08954a",
"assets/AssetManifest.bin.json": "ea16000d87f00cd60409f738824edef1",
"assets/AssetManifest.json": "e32e1fe8ce82f764bc64b8b9fd64d67a",
"assets/assets/images/anim_loading.json": "402c003d81255c11b459c570d23f590c",
"assets/assets/images/ic_android.png": "a344daceb32aed158c785f63385ef110",
"assets/assets/images/ic_app_store.svg": "33a40ce99d79823e0293f5c1b807b59e",
"assets/assets/images/ic_certification.svg": "65624cb9da1ab9365e57534156765881",
"assets/assets/images/ic_code.svg": "dc87c97e5d3ddaf31a2d072ad6833448",
"assets/assets/images/ic_dart.png": "80e0cfaf4e39a2700665ae5762d76645",
"assets/assets/images/ic_django.png": "b5a1b354e6c2d14c89f0e1d48509ca61",
"assets/assets/images/ic_figma.png": "ce6dc4ed61189ade55f7ced85ce7bcaf",
"assets/assets/images/ic_firebase.png": "c96ff29e54c68c01a6ae1871b37a45b1",
"assets/assets/images/ic_flutter.png": "6ba940675e2cd74bde86ba0bd4201309",
"assets/assets/images/ic_git.png": "0a12a85a4f9107d7fb147634b6008c04",
"assets/assets/images/ic_github.svg": "9d265d2164dad4feacb8ec287fa36225",
"assets/assets/images/ic_gmail.svg": "84aed0fc515065cdd0a516868cd2b81a",
"assets/assets/images/ic_google_play.svg": "15a91f1a3e71c08602fe4ab35f220469",
"assets/assets/images/ic_ig.svg": "d2468fd16e6685a0953f09a1c05d98af",
"assets/assets/images/ic_java.png": "7296622b91a05381fdd38955821abfad",
"assets/assets/images/ic_js.png": "e1fd56fea1d09c846992d362a4f47a72",
"assets/assets/images/ic_koper.svg": "ab8344167a49e138fa97e8a949f86057",
"assets/assets/images/ic_kotlin.png": "e965b11a337c089593e7e2690a2646c7",
"assets/assets/images/ic_linkedin.svg": "57ac68b7ee7438b0b5d60c8e8a24f170",
"assets/assets/images/ic_menu.svg": "db27551a17accccde0548301a61eeda1",
"assets/assets/images/ic_mysql.png": "15b3de4e088ac919eb8f1f5c3c7757de",
"assets/assets/images/ic_node.png": "0cf2a9830625d6cf5cf7b82c698270d3",
"assets/assets/images/ic_phyton.png": "b62fe70546407cb4f7b02d39d2bae515",
"assets/assets/images/ic_postman.png": "3ea38d2f537dfb48a759ad0e0682ff37",
"assets/assets/images/ic_project.svg": "67ec6c27c0327b3e507942bbcdb1829e",
"assets/assets/images/ic_react_js.png": "1394d581fd7ac0274b5a71c266becb5c",
"assets/assets/images/ic_react_native.png": "5d9f124bc8825292a8bbc560e50178cd",
"assets/assets/images/ic_studio.png": "f3f830ac6ad4b2f2d9f4be160ae1d4c3",
"assets/assets/images/ic_tele.svg": "1fd863a2a0bd7ec40f2b4e9500eca3eb",
"assets/assets/images/ic_tensorflow.png": "b00fb5b05d071c7eb2d1e4541a38c4c2",
"assets/assets/images/ic_trophy.svg": "3d495d486c6f9c599eb79e063b8ad202",
"assets/assets/images/ic_typescript.png": "f94faa4c6c893431257a692e42100fca",
"assets/assets/images/ic_vscode.png": "d36ef73f4c1b357c1f34f5a1fbf6a0ad",
"assets/assets/images/ic_wa.svg": "087a4fc768386cfd6522a0cc175b4ca1",
"assets/assets/images/ic_web.svg": "6885568e83c4404b3aaca4de3bc160cb",
"assets/assets/images/image_photo.jpg": "7cf041a88d9cb1343ffe3bac213cf952",
"assets/FontManifest.json": "5f46f88c864cf39d283e82b96b708340",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/google_fonts/OFL.txt": "69045d03afdf61aeb37246af6001af9c",
"assets/google_fonts/Poppins-Black.ttf": "14d00dab1f6802e787183ecab5cce85e",
"assets/google_fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/google_fonts/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/google_fonts/Poppins-ExtraLight.ttf": "6f8391bbdaeaa540388796c858dfd8ca",
"assets/google_fonts/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/google_fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/google_fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/google_fonts/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/google_fonts/Poppins-Thin.ttf": "9ec263601ee3fcd71763941207c9ad0d",
"assets/NOTICES": "b12d80f88807b6e38d023d430ab50c74",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "4507f154c354e5af483e737bca89594a",
"/": "4507f154c354e5af483e737bca89594a",
"main.dart.js": "5b4604331d8383a4fefeb3d6dc6f8c02",
"manifest.json": "972a0d4cb6d66824222b75404570d9a7",
"version.json": "a5dff98cb7ebbd0dfb1c10aa204aef5f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
