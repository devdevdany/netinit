#!/usr/bin/env bash

# usage: inside the project directory run `netinit`

# uncomment to debug
# set -x

set -Eeuo pipefail
IFS=$'\n\t'
trap_err() {
  exit_status_before_echo=${?}
  echo >&2 "${0}: Error on line ${LINENO}: ${BASH_COMMAND}"
  exit ${exit_status_before_echo}
}
trap trap_err ERR

project_name="$(basename "$(pwd)")"

csproj_path="./${project_name}/${project_name}.csproj"

dotnet new sln --name "${project_name}"
dotnet new web --name "${project_name}" --output "${project_name}"
curl --location --verbose --output "${csproj_path}" "https://raw.githubusercontent.com/devdevdany/dotnet-lint-and-format/main/Recommended.csproj"
dotnet sln add "${csproj_path}"

curl --location --verbose --output ".editorconfig" "https://raw.githubusercontent.com/devdevdany/dotnet-lint-and-format/main/.editorconfig"

dotnet new tool-manifest
dotnet tool install csharpier

echo "The .NET project \"${project_name}\" was successfully initialized."
