<template>
    <div>
        <v-dialog v-model="loading_processing" persistent width="55">
            <v-card width="55" height="55" class="pt-3 pl-3">
                <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
            </v-card>
        </v-dialog>
        <v-card class="card-shadow" rounded="lg">
            <v-card-title class="px-10" style="background-color:#E57373;color:white">
                <span>ລາຍການໃບປະຕິບັດ</span>
            </v-card-title>
            <v-card-text class="px-10 pb-10">
                <div class="py-4" style="display:flex;align-items:center">
                    <v-btn rounded color="#E57373" class="white--text card-shadow"
                        to="/leave-operation"><v-icon>mdi-plus</v-icon>ອອກໃບປະຕີບັດງານ</v-btn>
                    <h3 class="ml-4">ທັງໝົດ: <span class="green--text">{{ report_peration_list?.length }}</span></h3>
                </div>
                <div >
                    <v-data-table :items="report_peration_list" :headers="report_operation_header" :search="search"
                        style="border-radius:10px">
                        <template v-slot:item="row">
                            <tr :style="{ 'background-color': row?.item?.totalDay >= '7' ? '#FFCDD2' : '#fff' }">
                                <td>{{ row?.item?.key_ID }}</td>
                                <td>{{ row?.item?.performancebillno }}</td>
                                <td>{{ row?.item?.customer_NAME }}</td>
                                <td>{{ row?.item?.pro_NAME }}</td>
                                <td>{{ row?.item?.pro_TYPE }}</td>
                                <td>{{ row?.item?.performancedate }}</td>
                                <td class="green--text">{{ row?.item?.total_PRICE?.replace(/\B(?=(\d{3})+(?!\d))/g,
                                    ',') }} {{ row?.item?.currency }}</td>
                                <td v-if="row?.item?.status === 'N'">
                                    <div class="d-flex algin-center">
                                        <v-btn small color="red" class="white--text card-shadow" block>
                                            <v-icon color="white" size="24">mdi-new-box</v-icon>
                                            <span class="white--text ml-2">ລໍຖ້າອອກບິນ</span>
                                            <v-spacer></v-spacer>
                                        </v-btn>

                                    </div>
                                </td>
                                <td v-else>
                                    <div class="d-flex algin-center green--text">
                                        <v-btn small color="green" class="white--text" block>
                                            <v-icon color="white">mdi-check-circle</v-icon>
                                            <span class="ml-2">ສຳເລັດ</span>
                                            <v-spacer></v-spacer>
                                        </v-btn>
                                    </div>
                                </td>
                                <td>
                                    <v-btn @click="onGoToEdit(row?.item?.key_ID)" block small class="card-shadow" color="#FFB74D"><v-icon
                                            color="white">mdi-pencil</v-icon>
                                        <span class="white--text">ແກ້ໄຂ</span><v-spacer></v-spacer>
                                    </v-btn>
                                </td>

                            </tr>
                        </template>
                    </v-data-table>
                </div>
            </v-card-text>

        </v-card>
    </div>
</template>

<script>
export default {
    data() {
        return {
            search: '',
            loading_processing: false,
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
                { text: '', value: '' },
            ],
        }
    },
    mounted() {
        this.onGetAllPermance()
    },
    methods: {
        onGoToEdit(key) {
            this.$router.push({
                path: '/edit-operation',
                query: { key: key }
            })
        },
        onGetAllPermance() {
            this.loading_processing = true
            try {
                this.$axios.$post('/v_popupPerformance.service').then((data) => {
                    if (data?.data) {
                        this.loading_processing = false
                        this.report_peration_list = data?.data;
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
    }

}
</script>

<style></style>