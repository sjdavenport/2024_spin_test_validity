#!/bin/bash

for n in 5 ; do
TARGET=fsaverage${n}
mkdir -p  $/home/sdavenport/freesurfer_runs/mris_preproc
LIST=""
for sub in $(cat /home/sdavenport/freesurfer_runs/listofsubjects.csv) ; do  #listofsubjects.csv needs to contain the subject folder names i.e. OAS...
LIST="${LIST} --s ${sub}"
done
for f in 0 5 10 15; do
for meas in area thickness; do
for h in lh rh ; do
      ${FREESURFER_HOME}/bin/mris_preproc ${LIST} \
      --hemi ${h} \
      --target ${TARGET} \
      --meas ${meas} \
      --surfreg sphere.reg \
      --out /home/sdavenport/freesurfer_runs/mris_preproc/${h}.${meas}.ic${n}_fwhm${f}.mgz \
      --fwhm ${f} \
      --nocleanup ;
      rm -f /home/sdavenport/freesurfer_runs/mris_preproc/${h}.${meas}.ic${n}_fwhm${f}.mgz ;
      pid=$(awk '/tmpdir is/ {print $NF}' /home/sdavenport/freesurfer_runs/mris_preproc/${h}.${meas}.ic${n}_fwhm${f}.mris_preproc.log | awk -F. '{print $NF}') ;
      mv /home/sdavenport/freesurfer_runs/mris_preproc/tmp.mris_preproc.${pid} /home/sdavenport/freesurfer_runs/mris_preproc/${h}.${meas}.ic${n}_fwhm${f}.dir
done
done
done
done

# interpolation is nearest neighbour
# freesurfer contained here: /usr/pubsw/packages/freesurfer/RH4-x86_64-R530/
# fsaverage/surf/ls.sphere is the icosahedron
# /home/sdavenport/freesurfer_runs/mris_preproc/lh.thickness.ic3.dir