# Suhaili Faruq — Portfolio

My personal portfolio site, built with Flutter Web and hosted on Firebase.

Live: <https://portfolioweb-55f91.web.app>

The layout follows the [Graphics Designer Portfolio](https://dribbble.com/shots/26851273-Graphics-Designer-Portfolio-Design) shot by Dharmu Bhusal on Dribbble, recolored to my blue and amber palette.

## What's on the page

- **Hero and About**: a short summary taken from my resume and LinkedIn.
- **Skills**: mobile, backend, web, data, and tooling, each with the tools I use.
- **Experience**: a timeline read from Firestore.
- **Projects**: 36 projects read from Firestore. Private repositories carry a lock badge and no GitHub link.
- **Contact and footer**: email, socials, and a resume button that opens a Google Drive link.

Desktop has a top nav that marks the section on screen. Mobile and tablet use a floating pill bottom bar instead.

## Stack

| Area | Packages |
| --- | --- |
| UI | Flutter Web, `responsive_framework`, `gap`, `lottie`, `flutter_svg` |
| Icons | `iconify_flutter`, `colorful_iconify_flutter` |
| State and routing | `flutter_riverpod`, `go_router` |
| Data | `cloud_firestore` |
| Fonts | Nunito (headings) and Quicksand (body), bundled in `google_fonts/` |

## Project structure

```text
lib/
├── helper/        palette and router
├── model/         ExperienceModel, ProjectModel
├── repository/    Firestore queries
├── provider/      Riverpod notifiers
└── screen/
    ├── home_screen.dart   page layout, scroll tracking
    ├── component/         Section, PillButton, FloatingBadge, nav bars, cards
    └── page/              hero/about, skills, experience, projects, contact/footer
```

## Firestore data

The site reads three collections.

| Collection | Order | Fields |
| --- | --- | --- |
| `experience_work` | `date_start` desc | `company_name`, `position`, `type_work`, `location`, `date_start`, `date_end` (`YYYY-MM` or `Present`), `color_symbol`, `description` (one highlight per line) |
| `project_work` | `sort_order` asc | `project_name`, `type_project`, `project_by`, `framework_using`, `start_project`, `end_project`, `description_project`, `github_link`, `is_private`, `playstore_link`, `appstore_link`, `web_link` |
| `profile` | — | `resume` doc with a `url` field |

`framework_using` picks the logo on each project card, for example `Flutter`, `React Native`, `Kotlin`, `Go`, `Java Swing`, or `CodeIgniter 4`.

To change the resume, update `profile/resume.url` in the Firebase console. The site picks it up without a redeploy.

`firestore.rules` allows public reads and blocks every client write.

## Run locally

Requires the Flutter SDK (3.47 or later).

```bash
flutter pub get
flutter run -d chrome
```

## Deploy

`firebase.json` uses Firebase's framework-aware Hosting, so the CLI builds the Flutter app itself.

```bash
firebase login
firebase experiments:enable webframeworks
firebase deploy                        # hosting and Firestore rules
firebase deploy --only firestore:rules # rules only
```
