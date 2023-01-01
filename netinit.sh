#!/usr/bin/env bash

# usage, inside your project directory
# `netinit`

# uncomment to debug
# set -x

set -Eeuo pipefail

project_name="$(basename "$(pwd)")"

dotnet new sln --name "${project_name}"
dotnet new web --name "${project_name}" --output "${project_name}"
dotnet sln add "./${project_name}/${project_name}.csproj"

echo "The .NET project \"${project_name}\" was successfully initialized."
