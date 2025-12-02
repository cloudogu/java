# Containerbau

Dieses Container-Image bildet die Grundlage für viele Dogu-Container-Images.

## Anleitung zum Bauen und Bereitstellen

Auf einem Entwicklungs-Branch:

1. Aktualisiere die `Makefile` Felder `JAVA_VERSION`, `JAVA_ALPINE_VERSION` und `CHANGE_COUNTER` entsprechend.
2. PR/Merge den Entwicklungs-Branch in den Ziel-Branch.
3. Tagge den Ziel-Commit (z.B. `v3.45.6-7`) für den Release.

In der Jenkins Pipeline sind folgende Parameter verfügbar:
- `PublishRelease`
- `PublishPrerelease`

Werden diese Parameter aktiviert, wird das gebaute Image anschließend veröffentlicht.

Mit aktiviertem `PublishPrerelease` Parameter wird das Image im Namespace `registry.cloudogu.com/prerelease_official/` veröffentlicht.

Mit aktiviertem `PublishRelease` Parameter wird das Image im Namespace `registry.cloudogu.com/official/` veröffentlicht und es wird ein GitHub Release erstellt.

Um ältere Varianten des Images erneut zu bauen und zu veröffentlichen, stehen
Branches zu Verfügung, für welche der Build- & Release-Prozess mittels
Parameter analog zum Haupt-Branch gestartet werden kann.
