<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <v-card class="card-shadow mb-6" rounded="lg">
            <v-card-title style="background-color:#E57373;color:white">ລາຍງານໃບປະຕິບັດງານ</v-card-title>
            <v-card-text>
                <v-form ref="form" lazy-validation v-model="valid">
                    <div style="width:100%;display:flex" class="pt-4">

                        <div class="d-flex align-center">
                            <v-menu ref="start_menu" v-model="start_menu" :close-on-content-click="false"
                                :return-value.sync="start_date" transition="scale-transition" offset-y min-width="auto">
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field dense outlined v-model="start_date" required label="ວັນທີເລີ່ມຕົ້ນ"
                                        append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"
                                        :rules="nameRules"></v-text-field>
                                </template>
                                <v-date-picker v-model="start_date" no-title scrollable
                                    @input="$refs.start_menu.save(start_date)">
                                    <v-spacer></v-spacer>
                                </v-date-picker>
                            </v-menu>
                        </div>
                        <div class="d-flex align-center pl-2">
                            <v-menu ref="end_menu" v-model="end_menu" :close-on-content-click="false"
                                :return-value.sync="end_date" transition="scale-transition" offset-y min-width="auto">
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field dense outlined v-model="end_date" required label="ວັນທີສຸດທ້າຍ"
                                        append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"
                                        :rules="nameRules"></v-text-field>
                                </template>
                                <v-date-picker v-model="end_date" no-title scrollable
                                    @input="$refs.end_menu.save(end_date)">
                                    <v-spacer></v-spacer>
                                </v-date-picker>
                            </v-menu>
                        </div>
                        <div class="ml-2 pt-1">
                            <v-btn color="#90A4AE" elevation="0" class="white--text"
                                @click="onSeachPermance"><v-icon>mdi-magnify</v-icon>ຄົ້ນຫາ</v-btn>
                        </div>
                        <v-spacer></v-spacer>
                        <div style="width:300px">
                            <v-text-field placeholder="ຄົ້ນຫາດ້ວຍລະຫັດປ່ອຍລົດ..." v-model="search" rounded
                                background-color="#f5f5f5" prepend-inner-icon="mdi-magnify"></v-text-field>
                        </div>
                    </div>
                </v-form>
                <div style="display:flex;align-items:center">

                    <div v-if="showAlert === true"
                        style="border:1px solid red;height:40px;border-radius:3px;display:flex;align-items:center"
                        class="ml-2 pl-2 pr-10">
                        <v-icon color="red">mdi-alert-outline</v-icon>
                        <span class="ml-2 red--text">ລາຍການສີແດງຮອດກຳນົດແລ້ວ!</span>
                    </div>
                </div>

                <div style="margin-top:-15px" class="pb-3">
                    <h3>ທັງໝົດ: <span class="green--text">{{ report_peration_list?.length }}</span></h3>
                </div>
                <div>
                    <v-data-table :items="report_peration_list" :headers="report_operation_header" :search="search"
                        style="border-radius:10px">
                        <template v-slot:item="row">
                            <tr :style="{ 'color': row?.item?.totalDay >= '7' && row?.item?.status ==='N' ? 'red' : 'black' }">
                                <td>{{ row?.item?.key_ID }}</td>
                                <td>{{ row?.item?.performancebillno }}</td>
                                <td>{{ row?.item?.customer_NAME }}</td>
                                <td>{{ row?.item?.pro_NAME }}</td>
                                <!-- <td>{{ row?.item?.sainummun?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
                                }}</td>
                                <td>{{ row?.item?.priecenumnun?.replace(/\B(?=(\d{3})+(?!\d))/g,
                                    ',') }}</td>
                                <td>{{ row?.item?.totalnummun?.replace(/\B(?=(\d{3})+(?!\d))/g,
                                    ',') }}</td>
                                <td>{{ row?.item?.laiyathang }}</td> -->
                                <td>{{ row?.item?.pro_TYPE }}</td>
                                <td>{{ row?.item?.performancedate }}</td>
                                <td class="green--text">{{ row?.item?.total_PRICE?.replace(/\B(?=(\d{3})+(?!\d))/g,
                                    ',') }} {{ row?.item?.currency }}</td>
                                <td v-if="row?.item?.status === 'N'">
                                    <div class="d-flex algin-center">
                                        <v-btn small elevation="0" color="red" class="white--text" block>
                                            <v-icon color="white" size="24">mdi-new-box</v-icon>
                                            <span class="white--text ml-2">ລໍຖ້າອອກບິນ</span>
                                            <v-spacer></v-spacer>
                                        </v-btn>

                                    </div>
                                </td>
                                <td v-else>
                                    <div class="d-flex algin-center green--text">
                                        <v-btn small  color="green" class="white--text card-shadow" block>
                                            <v-icon color="white">mdi-check-circle</v-icon>
                                            <span class="ml-2">ສຳເລັດ</span>
                                            <v-spacer></v-spacer>
                                        </v-btn>
                                    </div>
                                </td>
                               
                                <td>
                                    <v-btn color="#2F7DBB" small  class="white--text card-shadow"
                                        @click="onGetDataListForPrint(row?.item?.key_ID)"><v-icon
                                            color="white">mdi-printer-pos-check-outline</v-icon><span
                                    >ພິມບິນຄືນ</span></v-btn>
                                </td>
                            </tr>
                        </template>
                    </v-data-table>
                </div>
            </v-card-text>

        </v-card>
        <!-- component for print  -->
        <div style="display:none;">
            <div id="modalInvoice">
                <v-row>
                    <v-col cols="3">
                        <img class="mx-auto" src="../assets/images/khounkham.png" height="70px" cover />
                    </v-col>
                    <v-col cols="9">
                        <div style="display:flex;justify-content:start;flex-direction:column;align-items:start">
                            <span style="font-size:14px"><b>ບໍລິສັດ ຄູນຄໍາ ຂຸດຄົ້ນຫີນກາວ ດົງເຫັນ </b> </span>
                            <span style="font-size:12px">ສໍານັກງານຕັ້ງຢູ່ ອາຄານ ສະໜາມຍິງປືນ 20 ມັງກອນ, ສະໜາມກີລາກອງທັບ,
                                ບ້ານຈອມມະນີ, ເມືອງ ໄຊເສດຖາ, ນະຄອນຫຼວງວຽງຈັນ, ສປປ ລາວ</span>
                            <span style="font-size:12px">ໂທລະສັບ: 020 92661111, 020 98753888 | ອີເມວ: kounkham@Mining |
                                ເວັບໄຊ: kounkham</span>
                        </div>
                    </v-col>
                </v-row>
                <br>

                <div class="text-center pb-10 pt-10 font-weight-bold"
                    style="display:flex;justify-content:center;font-size:18px">
                    <b>ໃບປະຕິບັດງານ</b></div>
                <div style="height:20px"></div>

                <div style="display:flex;justify-content:end;flex-direction:column;align-items:end">
                    <!-- <span style="font-size:12pt">ໜ້າທີ: 01</span> -->
                    <div style="border:0.5px solid #999;display:flex;flex-direction:column;padding:10px;border-radius:3px">
                        <span style="font-size:12px">ເລກທີ: {{ performanceSmallHeaderGruops?.keyId }}</span>
                        <span style="font-size:12px">ວັນທີ:
                            {{ performanceSmallHeaderGruops?.printDate }}</span>
                    </div>
                </div>
                <div style="display:flex;flex-direction:row;font-size:12px">
                    <span>ທະບຽນລົດ: {{ performanceheaderGruops?.h_VICIVLE_NUMBER }}</span>
                    <!-- <span style="margin-left:10px">ທະບຽນຫາງລົດ: B102145</span> -->
                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between; font-size:12px">
                    <div>
                        <span>ພະນັກງານຂັບ1: {{ performanceheaderGruops?.staffname }}</span>
                        <span style="margin-left:5px">ພະນັກງານຂັບ2:
                            {{ performanceheaderGruops?.staffname1 }}</span>
                    </div>

                </div>
                <div style="font-size:12px">
                    ວັນທີກັບ: {{ performaceGroupDetails?.perFORMANCEREDATE }}
                </div>
                <div style="padding-top:10px">
                    <table style="padding:2px;border: 0.5px solid #FFF;border-collapse: collapse;width:100%; font-size:12px">
                        <tr style="padding:5px;border: 0.5px solid #999;">
                            <td style="border: 0.5px solid #999;padding:5px">ລຳດັບ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ວັນທີສົ່ງ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ຊື່ລູກຄ້າ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ສິນຄ້າທີສົ່ງ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ເສັ້ນທາງ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ຊື່ຮ້ານຄ້າປາຍທາງ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ເລກທີສັ່ງງານ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ລາຍໄດ້</td>
                        </tr>
                        <tr style="padding:5px;border: 0.5px solid #999;">
                            <td style="border: 0.5px solid #999;padding:5px">1</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.perFORMANCEDATE }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.customer_NAME }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.pro_NAME }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.pro_TYPE }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.to_CUSTOMER }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ performaceGroupDetails?.lahud_POYLOD }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.total_PRICE }} {{ performaceGroupDetails?.currency }}</td>
                        </tr>
                        <tr style="padding:5px;border: 0.5px solid #999;">
                            <td style="border: 0.5px solid #999;padding:5px" colspan="7">ລວມທັງໝົດ</td>
                            <td style="border: 0.5px solid #999;padding:5px">
                                {{ performaceGroupDetails?.total_PRICE }} {{ performaceGroupDetails?.currency }}</td>
                        </tr>
                    </table>
                </div>
                <div style="padding-top:20px;display:flex;flex-direction:row;justify-content:space-between; font-size:12px">
                    <div>
                        <table style="padding:2px;border: 0.5px solid #FFF;border-collapse: collapse;width:100%">
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ລາຍການ</td>
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າໃຊ້ຈ່າຍ</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າບ້ຽງລ້ຽງ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.staff_BIALIENG }} {{ performaceGroupDetails?.staff_Cur }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າຈໍ້າປື້ມຕັ່ງສິດລົດ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancejumpho }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າຕຳລວດ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeepolish }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າປະຢາງ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefe_PAYANG }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າຕາຊັ່ງ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeetaxung }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າທ່ຽວ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeetiew }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າລ່ວງເວລາຢູ່ຫວຽດນາມ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performanceovervn }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າລ່ວງເວລາຢູ່ດ່ານຫຼັກ20</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performanceboderlak20 }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າປະທັບກາພາສປອດ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancepassport }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າຊິດຢາຕ້ານເສື້ອ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancevaccine }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າແຈ້ງຊີງ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeesing }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າສະພານ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeesaphan }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າຍົກຕູ້</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeeyoktu }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ຄ່າເອົາຕູ້ອອກຈາກດ່ານສາວ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.performancefeeoutcontainer }}</td>
                            </tr>
                            <tr style="padding:5px;border: 0.5px solid #999;">
                                <td style="border: 0.5px solid #999;padding:5px">ລວມລາຍຈ່າຍທັງໝົດ</td>
                                <td style="border: 0.5px solid #999;padding:5px">{{
                                    performaceGroupFee?.feetotal?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
                                }}</td>
                            </tr>

                        </table>
                    </div>
                    <div style="display:flex;flex-direction:column;justify-content:space-between">
                        <div>
                            <div style="border:1px solid #999;">
                                <div style="display:flex;justify-content:center">
                                    <span class="text--center">ຄ່າເຊື້ອເພີງ</span>
                                </div>
                                <v-divider></v-divider>
                                <div style="display:flex;flex-direction:column;padding:10px;width:280px">
                                    <div style="display:flex;flex-direction:row;justify-content:space-between">
                                        <span>ນໍ້າມັນເຕີມ</span>
                                        <v-spacer></v-spacer>
                                        <span>{{ performance_GroupFeePower?.saiNumMun }} ລິດ</span>
                                    </div>
                                    <div style="display:flex;flex-direction:row;justify-content:space-between">
                                        <span>ລາຄານໍ້າມັນຕໍ່ລິດ</span>
                                        <v-spacer></v-spacer>
                                        <span>{{ performance_GroupFeePower?.priceNumMun }}/ລິດ</span>
                                    </div>
                                    <div style="display:flex;flex-direction:row;justify-content:space-between">
                                        <span>ລວມ</span>
                                        <v-spacer></v-spacer>
                                        <span>{{ (performance_GroupFeePower?.totalNumMun)?.replace(/\D/g, '')
                                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</span>
                                    </div>
                                </div>
                                <v-divider></v-divider>
                                <div style="display:flex;flex-direction:column;padding:10px">
                                    <!-- <span></span>
                                    <span></span>
                                    <span></span> -->
                                    <div style="display:flex;flex-direction:column;padding:10px;width:280px">
                                        <div style="display:flex;flex-direction:row;justify-content:space-between">
                                            <span>ເລກໄມທ່ຽວກ່ອນ</span>
                                            <v-spacer></v-spacer>
                                            <span>{{ performance_GroupFeePower?.kimKiLo }}</span>
                                        </div>
                                        <div style="display:flex;flex-direction:row;justify-content:space-between">
                                            <span>ໄລຍະທາງທ່ຽວນີ້</span>
                                            <v-spacer></v-spacer>
                                            <span>{{ performance_GroupFeePower?.laiYaThang }}</span>
                                        </div>
                                        <!-- <div style="display:flex;flex-direction:row;justify-content:space-between">
                                            <span>ເລກໄມທ່ຽວນີ້</span>
                                            <v-spacer></v-spacer>
                                            <span>{{ performance_GroupFeePower?.lekMai }}</span>
                                        </div> -->
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div>
                            <div style="display:flex">
                                <div>ລົງຊື່</div>
                                <div style="border-bottom:1px solid #999;width:100%"></div>
                                <div style="width:70px">ຜູ້ຮັບເງິນ</div>
                            </div>
                            <br />
                            <div style="display:flex">
                                <div>ລົງຊື່</div>
                                <div style="border-bottom:1px solid #999;width:100%"></div>
                                <div style="width:80px">ຜູ້ຈ່າຍເງິນ</div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- customer -->
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            showAlert: false,
            valid: true,
            nameRules: [(v) => !!v || 'ຕ້ອງເລືອກ'],
            search: '',
            loading_processing: false,
            end_menu: false,
            end_date: null,
            start_menu: false,
            start_date: null,
            report_peration_list: [],
            report_operation_header: [
                { text: 'ເລກບິນ', value: 'key_ID' },
                { text: 'ເລກປ່ອຍລົດ', value: 'performancebillno' },
                { text: 'ຊື່ລູກຄ້າ', value: 'customer_NAME' },
                { text: 'ສິນຄ້າ', value: 'pro_NAME' },
                { text: 'ຮ້ານຄ້າປາຍທາງ', value: 'pro_TYPE' },
                { text: 'ວັນທີ', value: 'performancedate' },
                { text: 'ລາຄາທັງໝົດ', value: 'total_PRICE' },
                { text: 'ສະຖານະ', value: 'status' },
                { text: '', value: '' }
            ],
            per_key: '',
            // state for print 
            performaceGroupDetails: [],
            performaceGroupFee: [],
            performanceSmallHeaderGruops: [],
            performance_GroupFeePower: [],
            performanceheaderGruops: [],

        }

    },
    mounted() {
        this.onGetAllPermance()
    },
    methods: {
        onCheckAlert() {
            this.report_peration_list.map((list) => {
                if (list?.totalDay >= '7' && list?.status === 'N') {
                    this.showAlert = true
                    return
                } else {
                    this.showAlert = false
                    return
                }
            })
        },
        onGetDataListForPrint(key) {
            try {
                let data = {
                    performanceBillNo: key
                }
                this.loading_processing = true
                console.log("datadend:", data)
                this.$axios.$post('/ListPrintBillByNo.service', data).then((data) => {
                    console.log("dataForPrint:", data)
                    this.data_for_print = data;
                    this.performaceGroupDetails = data?.performaceGroupDetails[0],
                        this.performaceGroupFee = data?.performaceGroupFee[0],
                        this.performanceSmallHeaderGruops = data?.performanceSmallHeaderGruops[0],
                        this.performance_GroupFeePower = data?.performance_GroupFeePower[0],
                        this.performanceheaderGruops = data?.performanceheaderGruops[0]
                    setTimeout(() => {
                        this.loading_processing = false
                        this.print()
                    }, 1000);
                })
            } catch (error) {
                console.log(error)
            }
        },
        onGetAllPermance() {
            this.loading_processing = true
            try {
                this.$axios.$post('/ListViewPerformance.service').then((data) => {
                    if (data?.data) {
                        this.loading_processing = false
                        this.report_peration_list = data?.data;
                        console.log("data_all_permance:", data?.data)
                        this.onCheckAlert()
                    } else {
                        this.report_peration_list = []
                        this.loading_processing = false
                    }
                })
            } catch (error) {
                console.log(error)
                this.loading_processing = false
            }
        },
        onSeachPermance() {
            if (!this.$refs.form.validate()) return null;
            try {
                let data = {
                    performanceBillNo: this.per_key,
                    performanceReDate: this.start_date,
                    performanceDate: this.end_date
                }
                this.$axios.$post('/SearchBillPerformance.service', data).then((data) => {
                    if (data?.data) {
                        this.report_peration_list = data?.data;
                        console.log("search:", data?.data)
                    } else {
                        this.report_peration_list = []
                    }
                })
            } catch (error) {
                console.log(error)
            }
        },
        print() {
            const modal = document.getElementById("modalInvoice")
            const cloned = modal.cloneNode(true)
            let section = document.getElementById("print")
            if (!section) {
                section = document.createElement("div")
                section.id = "print"
                document.body.appendChild(section)
            }
            section.innerHTML = "";
            section.appendChild(cloned);
            window.print();
        },
    }
}
</script>

<style lang="scss">
@media screen {
    #print {
        display: none;
    }
}

@media print {
    @page {
        size: A4;
        margin: 1in;
    }

    body * {
        visibility: hidden;
    }

    #print,
    #print * {
        visibility: visible;
    }

    #print {
        position: absolute;
        top: 0px;
        right: 0px;
        left: 0px;
    }
}
</style>