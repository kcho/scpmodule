#M3
function scp_kcho {
    server=$1
    location=$2
    i=$3
    #ssh ${server} "mkdir ${location}/${i}"
    #scp -r ${i}/DTI.bedpostX ${server}:${location}/${i}/
    #scp -r ${i}/ROI ${server}:${location}/${i}/
    scp -r ${i}/registration/* ${server}:${location}/${i}/registration
    ssh ${server} "echo bash ${location}/1.script_from_dicom ${location}/${i} >> ${location}/toRun.sh"
}

for server in M1 M2 M3
do
    case ${server} in
        M1)
            location=/Volumes/CCNC_3T/KangIk/2014_05_DKI_project/phd/newDTI
            screenName=phd
            ssh ${server} "rm ${location}/toRun.sh"
            for i in FEP28_KMR FEP29_JJH FEP31_NYJ FEP32_YMS FEP33_LSJ FEP34_LYH FEP35_LBR FEP36_LKJ FEP37_HJJ FEP38_HNS FEP39_PJU FEP40_KSB FEP41_KKH NOR02_JIY NOR03_LYE NOR05_PSM NOR07_PSJ NOR09_JJK NOR10_KMW NOR13_SMY NOR17_YKH NOR18_JJM NOR20_JJR NOR24_YJA
            do
                scp_kcho ${server} ${location} ${i}
            done
            ;;
        M2)
            location=/Volumes/CCNC_M2_2/kcho/phd
            screenName=kcho_phdf
            ssh ${server} "rm ${location}/toRun.sh"
            for i in FEP01_KWJ FEP02_IDH FEP04_KSY FEP05_JHR FEP06_LJY FEP07_KHJ FEP08_JSM FEP09_KHW FEP10_PHJ FEP11_KJY FEP12_KAR FEP13_LHJ FEP14_LDE FEP15_HJS FEP16_JSW FEP18_LSY FEP19_LJY FEP21_KHA FEP22_JS FEP23_CYJ FEP24_CJY FEP25_KBK FEP26_LNK FEP27_LSK
            do
                scp_kcho ${server} ${location} ${i}
            done
            ;;
        M3)
            location=/Volumes/CCNC_M3_4/kcho/phd
            screenName=kcho
            ssh ${server} "rm ${location}/toRun.sh"
            for i in NOR26_YJH NOR28_SHM NOR34_CES NOR36_HYS NOR40_LJH NOR41_SMH NOR45_LSM NOR48_KTH NOR50_KEJ NOR52_PKJ NOR53_PSH NOR54_SSR NOR56_YIW NOR58_LMW NOR60_KSH NOR61_KSH NOR62_MBS NOR64_SSJ NOR65_LES NOR66_LDY NOR67_LYE NOR74_LYN NOR75_LSK NOR76_KKT NOR81_KSA
            do
                scp_kcho ${server} ${location} ${i}
            done
            ;;
    esac
    scp 1.script_from_dicom ${server}:${location}
    parallel_command=`echo parallel -a ${location}/toRun.sh -j 13`
    ssh ${server} "screen -S ${screenName} -X stuff \"${parallel_command}\"`echo -ne '\015'`"
done
