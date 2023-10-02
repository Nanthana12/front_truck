<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <v-card class="card-shadow mb-6" rounded="lg">
            <v-card-title style="display:flex;background-color:#568fb3;color:white">
                <v-btn fab elevation="0" dark width="30" height="30" small color="#338ABF" to="report_staft">
                    <v-icon color="white">mdi-arrow-left</v-icon>
                </v-btn>
                <v-spacer></v-spacer>
                ລາຍງານພະນັກງານ
                <v-spacer></v-spacer>
            </v-card-title>
            <v-form ref="form" v-model="valid" lazy-validation>
                <v-card-text>
                    <div class="row">
                        <!-- <div class="col-8">
                            <div class="d-flex align-center" style="width:100%">
                                <div class="d-flex align-center">
                                    <v-menu ref="start_menu" v-model="start_menu" :close-on-content-click="false"
                                        :return-value.sync="start_date" transition="scale-transition" offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field dense outlined v-model="start_date" required label="ວັນທີເລີ່ມ"
                                                append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="start_date" no-title scrollable
                                            @input="$refs.start_menu.save(start_date)">
                                            <v-spacer></v-spacer>
                                        </v-date-picker>
                                    </v-menu>
                                </div>
                                <div class="d-flex align-center pl-2">
                                    <v-menu ref="end_menu" v-model="end_menu" :close-on-content-click="false"
                                        :return-value.sync="end_date" transition="scale-transition" offset-y
                                        min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field dense outlined v-model="end_date" required label="ວັນທີສຸດທ້າຍ"
                                                append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                                        </template>
                                        <v-date-picker v-model="end_date" no-title scrollable
                                            @input="$refs.end_menu.save(end_date)">
                                            <v-spacer></v-spacer>
                                        </v-date-picker>
                                    </v-menu>
                                </div>

                                <div style="margin-top:-25px" class="ml-2">
                                    <v-btn color="green" class="white--text" elevation="0"
                                        @click="onSearcReport"><v-icon>mdi-magnify</v-icon>ຄົ້ນຫາ</v-btn>
                                </div>
                            </div>
                        </div> -->

                    </div>
                    <div style="display:flex;justify-content:space-between;width:100%">
                        <div style="width:100%;border-radius:5px" class="mr-6 pa-4">
                            <div class=" d-flex align-center" style="">
                                <div style="width:100%">
                                    <span>ຊື່</span>
                                    <v-text-field readonly flat solo dense background-color="#f5f5f5" placeholder="ປ້ອນລາຄາ"
                                        v-model="name"></v-text-field>
                                </div>
                                <div style="width:100%" class="pl-2">
                                    <span>ນາມສະກຸນ</span>
                                    <v-text-field readonly flat solo dense background-color="#f5f5f5" placeholder="ປ້ອນລາຄາ"
                                        v-model="surname"></v-text-field>
                                </div>
                                <div style="width:100%" class="pl-2">
                                    <span>ເບີໂທ</span>
                                    <v-text-field readonly flat solo dense background-color="#f5f5f5" placeholder="ປ້ອນລາຄາ"
                                        v-model="mobile"></v-text-field>
                                </div>
                                <div style="width:100%" class="pl-2">
                                    <span>ເລກໃບຂັບຂີ່</span>
                                    <v-text-field readonly flat solo dense background-color="#f5f5f5" placeholder="ປ້ອນລາຄາ"
                                        v-model="idCard"></v-text-field>
                                </div>
                                <div style="width:100%" class="pl-2">
                                    <span>ວັນທີໃບຂັບຂີ່ໝົດອາຍຸ</span>
                                    <v-text-field readonly flat solo dense background-color="#f5f5f5" placeholder="ປ້ອນລາຄາ"
                                        v-model="licenceExp"></v-text-field>
                                </div>

                            </div>
                            <h3>ລາຍລະອຽດຂອງແຕ່ລະທ່ຽວ</h3>
                            <v-data-table :items="staft_data_list" :headers="staft_headers" :search="search">
                                <template v-slot:item="row">
                                    <tr>
                                        <td><span>{{ row?.index + 1 }}</span></td>
                                        <td><span>{{ row?.item?.out_DATE }}</span> - <span
                                                class="ml-2">{{ row?.item?.in_DATE }}</span></td>
                                        <td>{{ row?.item?.h_VICIVLE_NUMBER }} </td>
                                        <td>{{ row?.item?.f_BRANCH }}
                                        </td>
                                        <td><span>{{ row?.item?.province }}</span> - <span class="ml-2">{{
                                            row?.item?.detail
                                        }}</span>
                                        </td>
                                        <!-- <td>{{
                                        row?.item?.staff_BIALIENG?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td> -->
                                        <!-- <td class="red--text">{{
                                        row?.item?.staff02_Notpay?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td> -->
                                        <!-- <td class="red--text">
                                        <v-btn small color="#1976D2" class="white--text card-shadow"
                                            @click="edit(row?.item?.staffID)"><v-icon
                                                color="white">mdi-pencil</v-icon>ລາຍລະອຽດ</v-btn>

                                    </td> -->

                                        <!-- <td><span>{{ row?.item?.staft_NAME }}</span> <span class="ml-2">{{
                                        row?.item?.staft_SURNAME
                                    }}</span></td>
                                    <td>{{ row?.item?.out_DATE }}</td>
                                    <td>{{ row?.item?.in_DATE }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALIENG_FRIST }} {{ row?.item?.staff_Cur }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALIENG }} {{ row?.item?.staff_Cur }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALINEG_KANGJAIY }} {{ row?.item?.staff_Cur }}</td> -->
                                    </tr>
                                </template>
                            </v-data-table>
                        </div>
                    </div>
                    <div>

                    </div>
                </v-card-text>
            </v-form>
            <div
                    style="position:fixed;top: 97%;left: 50%;transform: translate(-50%, -50%); width:100%;background-color:#f5f5f5;display:flex;justify-content:center;height:50px;align-items:center">
                    <v-btn width="200" color="green" class="card-shadow" @click="print">
                        <v-icon color="white">mdi-printer</v-icon>
                        <span class="white--text pl-2">ພີມລາຍງານ</span>
                    </v-btn>
                </div>
        </v-card>

        <!-- component for print -->
        <div style="display:none;">
            <div id="modalInvoice">
                <div class="text-center pb-10 font-weight-bold" style="display:flex;justify-content:center;font-size:12pt">
                    ລາຍງານຂໍ້ມູນພະນັກງານ</div>
                <div style="height:10px"></div>
                <!-- <div style="display:flex;justify-content:end;flex-direction:column;align-items:end">
                    <div style="display:flex;flex-direction:column;padding:10px;border-radius:3px;border:1px solid #999">

                        <span style="font-size:12pt">ເລກທີ: {{ name }}</span>
                        <span style="font-size:12pt">ວັນທີປ່ອຍ: {{ mobile }}</span>
                        <span style="font-size:12pt">ວັນທີກັບ: {{ licenceExp }}</span>
                    </div>
                </div> -->
                <!-- customer -->
                <div style="display:flex;flex-direction:row;justify-content:space-between;">
                    <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ຊື່ ແລະ ນາມສະກຸນ: {{
                        name }} {{ surname }}</span>
                    </div>
                    <div style="width:100%"><span style="font-size:12pt">ເບີໂທ: {{ mobile }}; {{ mobile1 }}</span></div>

                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between;">
                    <div style="width:100%;display:flex;align-items:end"><span style="font-size:12pt">ເລກໃບຂັບຂີ່: {{ idCard
                    }}</span>
                    </div>
                    <div style="width:100%"><span style="font-size:12pt">ວັນທີໃບຂັບຂີ່ໝົດອາຍຸ: {{ licenceExp }} </span>
                    </div>
                </div>
                <div>
                    <div class="py-4 text-center">
                        <h3>ລາຍລະອຽດຂອງແຕ່ລະທ່ຽວ</h3>
                    </div>
                    <table style="padding:2px;border: 0.5px solid #FFF;border-collapse: collapse;width:100%">
                        <tr style="padding:5px;border: 0.5px solid #999;">
                            <td style="border: 0.5px solid #999;padding:5px">ລໍາດັບ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ວັນທີໄປ - ວັນທີກັບ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ຫົວລົດ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ຫາງລົດ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ສິນຄ້າ</td>
                            <td style="border: 0.5px solid #999;padding:5px">ສະຖານທີ</td>
                        </tr>
                        <tr style="padding:5px;border: 0.5px solid #999;" v-for="(item, i) in staft_data_list" :key="i">
                            <td style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000"
                                class="  text-center">
                                {{ i + 1 }}
                            </td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ item?.out_DATE }} - {{ item?.in_DATE }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ item?.h_VICIVLE_NUMBER }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ item?.f_BRANCH }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ item?.staff_BIALIENG }}</td>
                            <td style="border: 0.5px solid #999;padding:5px">{{ item?.province }} - {{ item?.detail }}</td>
                        </tr>
                       
                    </table>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import swal from 'sweetalert2'
export default {
    data() {
        return {
            staftID: '',
            loading_processing: false,
            end_menu: false,
            end_date: null,
            start_menu: false,
            start_date: null,
            search: '',
            staft_data_list: [],
            staft_headers: [
                { text: 'ລ/ດ', value: ''},
                { text: 'ວັນທີໄປ - ວັນທີກັບ', value: '' },
                { text: 'ຫົວລົດ', value: '' },
                { text: 'ຫາງລົດ', value: '' },
                // { text: 'ສິນຄ້າ', value: '' },
                { text: 'ສະຖານທີ', value: '' },
                // { text: 'ບ້ຽງລ້ຽງທັງໝົດ', value: '' },
                // { text: '', value: '' }
            ],
            valid: true,
            nameRules: [(v) => !!v || 'ຕ້ອງເລືອກວັນທີ'],

            name: '',
            surname: '',
            mobile: '',
            mobile1: '',
            idCard: '',
            licenceExp: '',

            h_VICIVLE_NUMBER: ''
        }
    },
    mounted() {
        if (this.$route.query.key) {
            this.ongetData()
            this.onGetEmployeeList()
        }
    },
    methods: {
        async ongetData() {
            try {
                // this.loading_processing = true;
                await this.$axios.$post('listPaymentStaff.service', { key_id: this.$route.query.key }).then((data) => {
                    // this.loading_processing = false;
                    console.log("dataUpd", data)
                    this.staft_data_list = data?.data;
                    this.report_emp_list = data?.data[0];
                    this.h_VICIVLE_NUMBER = data?.data[0]?.h_VICIVLE_NUMBER;
                    this.f_BRANCH = data?.data[0]?.f_BRANCH,
                        this.out_DATE = data?.data[0]?.out_DATE,
                        this.in_DATE = data?.data[0]?.in_DATE,
                        this.province = data?.data[0]?.province,
                        this.detail = data?.data[0]?.detail
                })
            } catch (error) {
                swal.fire({
                    icon: 'error',
                    text: error
                })
                this.loading_processing = false
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
        

        async onGetEmployeeList() {
            try {
                // this.loading_processing = true;
                await this.$axios.$post('getChooseStaft01.service', { key_id: this.$route.query.key }).then((data) => {
                    // this.loading_processing = false;
                    console.log("dataUpd", data)
                    // this.staft_data_list = data?.data;

                    this.name = data?.data[0]?.name;
                    this.surname = data?.data[0]?.surname,
                        this.mobile = data?.data[0]?.mobile,
                        this.mobile1 = data?.data[0]?.mobile1,
                        this.idCard = data?.data[0]?.idCard,
                        this.licenceExp = data?.data[0]?.licenceExp
                })
            } catch (error) {
                swal.fire({
                    icon: 'error',
                    text: error
                })
                this.loading_processing = false
                console.log(error)
            }
        },

        // onSearcReport() {

        //     this.loading_processing = true;
        //     try {
        //         let data = {
        //             staftID: this.$route?.query?.key
        //         }
        //         console.log("datadend:", data)
        //         // this.$axios.$post('/ReportStaff.service', data).then((data) => {
        //         this.$axios.$post('/listPaymentStaff.service', data).then((data) => {
        //             console.log("staft:", data)
        //             if (data?.status === '00') {
        //                 this.staft_data_list = data?.data;
        //                 this.loading_processing = false
        //             } else {
        //                 this.loading_processing = false
        //                 swal.fire({
        //                     icon: 'error',
        //                     text: data?.message
        //                 })
        //             }
        //         })
        //     } catch (error) {
        //         this.loading_processing = false
        //         swal.fire({
        //             icon: 'error',
        //             text: error
        //         })
        //         console.log(error)
        //     }
        // },
        // onGetEmployeeList(){
        //     this.loading_processing = true;
        //     try {
        //         let data = {
        //             staftID: this.$route?.query?.key
        //         }
        //         console.log("datadend:", data)
        //         // this.$axios.$post('/ReportStaff.service', data).then((data) => {
        //         this.$axios.$post('/getChooseStaft01.service', staftID).then((data) => {
        //             console.log("staft:", data)
        //             if (data?.status === '00') {
        //                 this.staft_data_list = data?.data;
        //                 this.loading_processing = false
        //             } else {
        //                 this.loading_processing = false
        //                 swal.fire({
        //                     icon: 'error',
        //                     text: data?.message
        //                 })
        //             }
        //         })
        //     } catch (error) {
        //         this.loading_processing = false
        //         swal.fire({
        //             icon: 'error',
        //             text: error
        //         })
        //         console.log(error)
        //     }
        // }
    }
}
</script>

<style>
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