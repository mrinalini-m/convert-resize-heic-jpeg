
cd ./images/
images=()
rm -rf renamed jpegs_100 resized
for f in *; do images+=("${f}"); done
mkdir renamed jpegs_100 resized 
for f in *; do if [[ "${images[@]}" =~ "${f}" ]]; then cp "${f}" ./renamed; fi; done
for f in ./renamed/*; do mv "$f" "$f.tmp"; mv "$f.tmp" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done                  
echo Successfully formatted image names...

for f in ./renamed/*.jpeg; do mv "${f}" ./jpegs_100; done
for f in ./renamed/*; do mogrify -path "./jpegs_100" -format jpeg "${f}"; done  

echo Successfully converted heics to jpegs...

for f in ./jpegs_100/*.jpeg;
  do echo Resizing $(basename "${f}") && mogrify -path "./resized" -filter Triangle -define filter:support=2 -thumbnail "50%" -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 85 -define heic:fancy-upsampling=off -define heic:compression-filter=5 -define heic:compression-level=9 -define heic:compression-strategy=1 -define heic:exclude-chunk=all -interlace none -colorspace sRGB "${f}";
done

echo Successfully resized images...
rm -rf jpegs_100 renamed