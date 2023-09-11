<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <v-card class="card-shadow mb-6" rounded="lg">
            <v-card-title  style="border-bottom:0.5px solid #e0e0e0;background-color:#568fb3;color:white">ລາຍງານພະນັກງານ</v-card-title>
            <v-form ref="form" v-model="valid" lazy-validation>
                <v-card-text>
                    <div class="d-flex align-center" style="width:100%">
                        
                        <div class="d-flex align-center">
                            <v-menu ref="start_menu" v-model="start_menu" :close-on-content-click="false"
                                :return-value.sync="start_date" transition="scale-transition" offset-y min-width="auto">
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field dense outlined v-model="start_date" required label="ວັນທີເລີ່ມ"
                                        append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"
                                        ></v-text-field>
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
                                        ></v-text-field>
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
                    <div style="margin-top:-15px">
                        <h3>ທັງໝົດ: <span class="green--text">{{ staft_data_list.length }}</span></h3>
                    </div>
                    <div>
                        <v-data-table :items="staft_data_list" :headers="staft_headers" >
                            <template v-slot:item="row">
                                <tr>
                                    <td><span>{{ row?.item?.staft_NAME }}</span> <span class="ml-2">{{
                                        row?.item?.staft_SURNAME
                                    }}</span></td>
                                    <td>{{ row?.item?.out_DATE }}</td>
                                    <td>{{ row?.item?.in_DATE }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALIENG_FRIST }} {{ row?.item?.staff_Cur }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALIENG }} {{ row?.item?.staff_Cur }}</td>
                                    <td class="red--text">{{ row?.item?.staff_BIALINEG_KANGJAIY }} {{ row?.item?.staff_Cur }}</td>
                                </tr>
                            </template>
                        </v-data-table>
                    </div>
                </v-card-text>
            </v-form>
        </v-card>
    </div>
</template>

<script>
import swal from 'sweetalert2'
export default {
    data() {
        return {
            loading_processing: false,
            end_menu: false,
            end_date: null,
            start_menu: false,
            start_date: null,
            staft_data_list: [],
            staft_headers: [
                { text: 'ຊື່ ແລະ ນາມສະກຸນ', value: '' },
                { text: 'ວັນທີອອກເດີນທາງ', value: '' },
                { text: 'ວັນທີກັບ', value: '' },
                { text: 'ບ້ຽງລ້ຽງທັງມົດ', value: '' },
                { text: 'ບ້ຽງລ້ຽງຈ່າຍກ່ອນ', value: '' },
                { text: 'ບ້ຽງລ້ຽງຄ້າງຈ່າຍ', value: '' },
            ],
            valid: true,
            nameRules: [(v) => !!v || 'ຕ້ອງເລືອກວັນທີ'],
        }
    },
    mounted(){
        this.onSearcReport()
    },
    methods: {
        onSearcReport() {
           
            this.loading_processing = true;
            try {
                let data = {
                    startDate: this.start_date,
                    endDate: this.end_date
                }
                this.$axios.$post('/ReportStaff.service', data).then((data) => {
                    console.log("staft:", data)
                    if (data?.status === '00') {
                        this.staft_data_list = data?.data;
                        this.loading_processing = false
                    } else {
                        this.loading_processing = false
                        swal.fire({
                            icon: 'error',
                            text: data?.message
                        })
                    }
                })
            } catch (error) {
                this.loading_processing = false
                swal.fire({
                    icon: 'error',
                    text: error
                })
                console.log(error)
            }
        }
    }
}
</script>

<style></style>