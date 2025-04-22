ghinstall() {
  if [[ "$1" == "" ]]; then
    echo "Usage: ghinstall <owner>/<repo>"
    return 1
  fi

  owner=$(echo "$1" | cut -d'/' -f1)
  repo=$(echo "$1" | cut -d'/' -f2)

  echo "🔎 Checking install permission for $owner/$repo..."

  permission=$(curl -fsSL "https://ghinstall.github.io/permission/permission.txt")

  if [[ "$permission" == "Permission [GRANTED] - ok to install" ]]; then
    echo "✅ Permission granted. Downloading $repo..."
    git clone "https://github.com/${owner}/${repo}.git"
  elif [[ "$permission" == "Permission [DENIED] - do not install" ]]; then
    echo "❌ Install denied. Please try again later."
  elif [[ "$permission" == "Permission [DENIED] - under maintanence" ]]; then
    echo "🛠️ Currently under maintenance. Please try again later."
  else
    echo "⚠️ Invalid or unknown permission response. Aborting."
    return 1
  fi
}
