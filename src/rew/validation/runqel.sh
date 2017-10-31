#!/bin/bash

##### SETTINGS #####

ENERGY_MIN=500
ENERGY_MAX=1500
ENERGY_STEP=500

MA_MIN=800
MA_MAX=1200
MA_STEP=200

OUTDIR="qelma/"
mkdir -p $OUTDIR

##### SIMULATIONS ######

# for energy in $(seq $ENERGY_MIN $ENERGY_STEP $ENERGY_MAX)
# do
#     for ma in $(seq $MA_MIN $MA_STEP $MA_MAX)
#     do
#         ../../../bin/nuwro -i "parqel.txt" \
#             -p "beam_particle = 14" \
#             -p "beam_energy = $energy" \
#             -p "qel_cc_axial_mass = $ma" \
#             -p "qel_nc_axial_mass = $ma" \
#             -p "dyn_qel_cc = 1" \
#             -p "dyn_qel_nc = 0" \
#             -o "${OUTDIR}/numu${energy}_cc_ma${ma}.root" &

#         ../../../bin/nuwro -i "parqel.txt" \
#             -p "beam_particle = 14" \
#             -p "beam_energy = $energy" \
#             -p "qel_cc_axial_mass = $ma" \
#             -p "qel_nc_axial_mass = $ma" \
#             -p "dyn_qel_cc = 0" \
#             -p "dyn_qel_nc = 1" \
#             -o "${OUTDIR}/numu${energy}_nc_ma${ma}.root" &

#         ../../../bin/nuwro -i "parqel.txt" \
#             -p "beam_particle = -14" \
#             -p "beam_energy = $energy" \
#             -p "qel_cc_axial_mass = $ma" \
#             -p "qel_nc_axial_mass = $ma" \
#             -p "dyn_qel_cc = 1" \
#             -p "dyn_qel_nc = 0" \
#             -o "${OUTDIR}/numubar${energy}_cc_ma${ma}.root" &

#         ../../../bin/nuwro -i "parqel.txt" \
#             -p "beam_particle = -14" \
#             -p "beam_energy = $energy" \
#             -p "qel_cc_axial_mass = $ma" \
#             -p "qel_nc_axial_mass = $ma" \
#             -p "dyn_qel_cc = 0" \
#             -p "dyn_qel_nc = 1" \
#             -o "${OUTDIR}/numubar${energy}_nc_ma${ma}.root"
#     done
# done

##### REWEIGHTING #####

# for energy in $(seq $ENERGY_MIN $ENERGY_STEP $ENERGY_MAX)
# do
#     for ma in $(seq $MA_MIN $MA_STEP $MA_MAX)
#     do
#         ../../../bin/reweight_to \
#             "${OUTDIR}/numu${energy}_cc_ma800.root" \
#             -o "${OUTDIR}/numu${energy}_cc_rewto_ma${ma}.root" \
#             -p qel_cc_axial_mass $ma \
#             -p qel_nc_axial_mass $ma &

#         ../../../bin/reweight_to \
#             "${OUTDIR}/numu${energy}_nc_ma800.root" \
#             -o "${OUTDIR}/numu${energy}_nc_rewto_ma${ma}.root" \
#             -p qel_cc_axial_mass $ma \
#             -p qel_nc_axial_mass $ma &

#         ../../../bin/reweight_to \
#             "${OUTDIR}/numubar${energy}_cc_ma800.root" \
#             -o "${OUTDIR}/numubar${energy}_cc_rewto_ma${ma}.root" \
#             -p qel_cc_axial_mass $ma \
#             -p qel_nc_axial_mass $ma &

#         ../../../bin/reweight_to \
#             "${OUTDIR}/numubar${energy}_nc_ma800.root" \
#             -o "${OUTDIR}/numubar${energy}_nc_rewto_ma${ma}.root" \
#             -p qel_cc_axial_mass $ma \
#             -p qel_nc_axial_mass $ma
#     done
# done

###### RUN MACRO ######

for energy in $(seq $ENERGY_MIN $ENERGY_STEP $ENERGY_MAX)
do
    for ma in $(seq $MA_MIN $MA_STEP $MA_MAX)
    do
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numu${energy}_cc_ma${ma}')" &
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numu${energy}_nc_ma${ma}')" &      
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numu${energy}_cc_rewto_ma${ma}')" &
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numu${energy}_nc_rewto_ma${ma}')"
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numubar${energy}_cc_ma${ma}')" &
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numubar${energy}_nc_ma${ma}')" &
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numubar${energy}_cc_rewto_ma${ma}')" &
        ../../../bin/myroot -b -q "qel.c('${OUTDIR}/numubar${energy}_nc_rewto_ma${ma}')"        
    done
done