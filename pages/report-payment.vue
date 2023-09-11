<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <v-card class="card-shadow mb-6" rounded="lg">
            <div style="border-bottom:0.5px solid #e0e0e0;display:flex;align-items:center;background-color:#568fb3;color:white"
                class="px-4">
                <span>ລາຍງານໃບບິນຮັບເງິນ</span>
                <v-spacer></v-spacer>
                <div>
                    <v-text-field placeholder="ຄົ້ນຫາ..." v-model="search" rounded background-color="#fff"
                        prepend-inner-icon="mdi-magnify"></v-text-field>
                </div>
            </div>
            <v-card-text>

                <div>
                    <h3>ທັງໝົດ: <span class="green--text">{{
                        (report_payment_list?.length).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</span></h3>
                </div>
                <div>
                    <v-data-table :items="report_payment_list" :headers="report_payment_headers" :search="search"
                        >
                        <template v-slot:item="row">
                            <tr>
                                <td>{{ row?.index + 1 }}</td>
                                <td>{{ row?.item?.billNo }}</td>
                                <td>{{ row?.item?.cusName }}</td>
                                <td>{{ row?.item?.paymentType }}</td>
                                <td v-if="row?.item?.bankName">{{ row?.item?.bankName }}</td>
                                <td v-else>ບໍມີຂໍ້ມູນ</td>
                                <td>{{ row?.item?.refNo }}</td>
                                <td class="font-weight-bold green--text">{{ row?.item?.amount?.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ row?.item?.currency }}</td>
                                <td class="font-weight-bold green--text">{{ row?.item?.payAmount?.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ row?.item?.currency }}</td>
                                <td class="font-weight-bold red--text">{{ row?.item?.noPayAmount?.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ row?.item?.currency }}</td>
                                <td>{{ row?.item?.payDate }}</td>
                                <td><v-btn small color="primary" elevation="0"
                                        @click="onGetDataForPrintBill(row?.item?.billNo)"><v-icon>mdi-printer</v-icon>ພິມບິນຄືນ</v-btn>
                                </td>
                            </tr>
                        </template>
                    </v-data-table>
                </div>
            </v-card-text>
        </v-card>
        <!-- component for print -->
        <div style="display:none;">
            <div id="modalInvoice">
                <div class="text-center pb-10 pt-10 font-weight-bold"
                    style="display:flex;justify-content:center;font-size:14pt">
                    ໃບບິນຮັບເງິນ</div>
                <div class="text-center pb-10 pt-10 font-weight-bold"
                    style="display:flex;justify-content:center;font-size:12pt">
                    RECIIPT</div>
                <div style="display:flex;flex-direction:row;justify-content:end;padding-top:50px">
                    <span style="font-size:12pt">ເລກປະຈຳຕົວຜູ້ເສຍພາສີ</span>
                    <div style="width:50px"></div>
                    <span style="font-size:12pt">(ສຳນັກງານໃຫຍ່)</span>
                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between;margin-top:10px;width:100%">
                    <div
                        style="width:100%;display:flex;flex-direction:column;border:0.5px solid #999;padding:5px;border-radius:3px;margin-right:50px">
                        <span style="font-size:12pt">ລະຫັດລູກຄ້າ: {{ data_for_print_header?.cusId }}</span>
                        <span style="font-size:12pt">ຊື່ລູກຄ້າ: {{ data_for_print_header?.cusName }}</span>
                        <span style="font-size:12pt">{{ data_for_print_header?.location }}</span>
                    </div>
                    <div
                        style="width:50%;display:flex;flex-direction:column;justify-content:center;border:0.5px solid #999;padding:5px;border-radius:3px">
                        <span style="font-size:12pt">ວັນທີ: {{ data_for_print_header?.printDate }}</span>
                        <span style="font-size:12pt">ເລກທີບິນ: {{ data_for_print_header?.billNo }}</span>
                    </div>
                </div>

                <div style="margin-top:20px">
                    <table style="padding:2px;border: 0.5px solid #FFF;border-collapse: collapse;width:100%">
                        <tr style="padding:5px;border: 0.5px solid #999;">
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ລຳດັບ</td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ລະຫັດສິນຄ້າ</td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ລາຍລະອຽດ</td>
                            <!-- <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ຈຳນວນ</td> -->
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ລາຄາ</td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">ລາຄາລວມ</td>
                        </tr>
                        <tr style="padding:5px;font-size:12pt;border: 0.5px solid #999;"
                            v-for="(d, i) in data_for_print_bill" :key="i">
                            <td
                                style="padding:5px;font-size:12pt;display:flex;justify-content:center;width:100%;align-items:center">
                                {{
                                    i + 1 }}</td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt"> {{ d?.proId }} </td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{ d?.proName_type }}</td>
                            <!-- <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{
                                d?.priceUnit?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td> -->
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{
                                d?.proTotal?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ d?.currency }}</td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{
                                d?.amountTotalS?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ d?.currency }}</td>
                            <!-- <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{
                                d?.payAmount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} </td>
                            <td style="border: 0.5px solid #999;padding:5px;font-size:12pt">{{
                                d?.noPayAmount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} </td> -->

                        </tr>
                        <tr style="padding:5px">
                            <td style="padding:5px;font-size:12pt" colspan="4">
                                <div style="display:flex;justify-content:end">ລາຄາລວມທັງໝົດ:</div>
                            </td>
                            <td style="padding:5px">
                                <div style="display:flex;justify-content:end">{{ data_for_print_footer?.totalAmount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ data_for_print_bill[0]?.currency }}</div>
                                
                            </td>
                        </tr>
                        <tr style="padding:5px">
                            <td style="padding:5px;font-size:12pt" colspan="4">  <div style="display:flex;justify-content:end">ຈຳນວນເງິນທີຊຳລະແລ້ວ:</div></td>
                            <td style="padding:5px">
                                <div style="display:flex;justify-content:end"> {{ data_for_print_footer?.sumPayamount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ data_for_print_bill[0]?.currency }}</div>
                               
                            </td>
                        </tr>
                        <tr style="padding:5px">
                            <td style="padding:5px;font-size:12pt" colspan="4"> <div style="display:flex;justify-content:end">ຈຳນວນເງິນທີຄ້າງຊຳລະ:</div></td>
                            <td style="padding:5px">
                                <div style="display:flex;justify-content:end"> {{ data_for_print_footer?.sumNoPayAmount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} {{ data_for_print_bill[0]?.currency }}</div>
                               
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="font-size:12pt">
                    ໝາຍເຫດ
                </div>
                <div style="display:flex;flex-direction:row;justify-content:space-between;margin-top:120px">
                    <div style="width:100%;display:flex;flex-direction:column;justify-content:start;align-items:center">
                        <div style="font-size:12pt">ບັນຊີຄັງເງິນ</div>

                        <div style="display:flex;justify-content:space-between;margin-top:20px">
                            ...........................................
                        </div>
                        <div style="margin-top:30px;font-size:12pt">
                            ວັນທີ:......................................
                        </div>
                    </div>
                    <div style="width:100%;display:flex;flex-direction:column;justify-content:end;align-items:center">
                        <div style="font-size:12pt">ທ່ານປະທານບໍລິສັດຄູນຄຳ</div>
                        <div style="display:flex;justify-content:space-between;margin-top:20px">
                            ............................................
                        </div>
                        <div style="margin-top:30px;font-size:12pt">
                            ວັນທີ:........................................
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            report_payment_list: [],
            report_payment_headers: [
                { text: 'ລ/ດ', value: '' },
                { text: 'ເລກບິນ', value: 'billNo' },
                { text: 'ຊື່ລູກຄ້າ', value: 'cusName' },
                { text: 'ປະເພດຊຳລະ', value: 'paymentType' },
                { text: 'ທະນະຄານ', value: 'bankName' },
                { text: 'ເລກອ້າງອີງ', value: 'refNo' },
                { text: 'ຈຳນວນເງິນທັງໝົດ', value: 'amount' },
                { text: 'ຈຳນວນເງິນທີຊຳລະແລ້ວ', value: 'payAmount' },
                { text: 'ຈຳນວນເງິນທີຄ້າງຊຳລະ', value: 'noPayAmount' },
                { text: 'ວັນທີຊຳລະ', value: 'payDate' },
                { text: '', value: '' },
            ],
            search: '',
            data_for_print_bill: [],
            data_for_print_footer: '',
            data_for_print_header: {},
            loading_processing: false
        }
    },
    mounted() {
        this.onGetAllPayMenList()
    },
    methods: {
        onGetAllPayMenList() {
            try {
                this.$axios.$post('/listTxnPay.service').then((data) => {
                    console.log("PList:", data)
                    this.report_payment_list = data?.data;
                })
            } catch (error) {
                console.log(error)
            }
        },
        onGetDataForPrintBill(key) {
            this.loading_processing = true
            try {
                let data = {
                    billNo: key
                }
                this.$axios.$post('/listBillPaymentByNo.service', data).then((data) => {
                    this.data_for_print_bill = data?.details
                    this.data_for_print_footer = data?.footer[0]
                    this.data_for_print_header = data?.header[0]
                    setTimeout(() => {
                        this.print()
                        this.loading_processing = false
                    }, 1000);
                })
            } catch (error) {
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