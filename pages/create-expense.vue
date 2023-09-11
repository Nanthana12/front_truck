<template>
    <div>
        <!-- <div>ບັນທຶກລາຍຈ່າຍ</div> -->
        <div class="d-flex align-center">
            <v-form v-model="valid" ref="form" lazy-validation>
                <div style="height:80vh;width:350px;border-radius:5px;border:1px solid #e0e0e0" class="pa-8">
                    <v-select dense outlined label="ເລືອກປະເພດລາຍຈ່າຍ" v-model="type" :items="expense_list_type"
                        item-text="typeName" item-value="key_id" :rules="nameRules"></v-select>
                    <v-text-field dense outlined label="ຈຳນວນ" v-model="amount" :rules="nameRules"></v-text-field>
                    <v-text-field dense outlined label="ລາຄາ/ອັນ" v-model="perAmount" :rules="nameRules"></v-text-field>
                    <v-text-field dense outlined label="ລາຄາທັງໝົດ" v-model="totalAmount" readonly
                        :rules="nameRules"></v-text-field>
                    <v-menu ref="start_menu" v-model="start_menu" :close-on-content-click="false"
                        :return-value.sync="dateSave" transition="scale-transition" offset-y min-width="auto">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field dense outlined v-model="dateSave" :rules="nameRules" required label="ວັນທີຈ່າຍຄ່າ"
                                append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                        </template>
                        <v-date-picker v-model="dateSave" no-title scrollable @input="$refs.start_menu.save(dateSave)">
                            <v-spacer></v-spacer>
                        </v-date-picker>
                    </v-menu>
                    <div>
                        <v-btn elevation="0" block color="#4AAF41" class="white--text" @click="onSave">ເພີ່ມ</v-btn>
                    </div>
                </div>
            </v-form>
            <v-dialog v-model="updateDia" max-width="400">
                <v-card>
                    <v-card-title>ແກ້ໄຂ</v-card-title>
                    <v-card-text>
                        <div style="border-radius:5px;background-color:#f5f5f5" class="pa-8">
                            <v-select dense outlined label="ເລືອກປະເພດລາຍຈ່າຍ" v-model="type1"
                                :items="list_expense_type_for_up"></v-select>
                            <v-text-field dense outlined label="ຈຳນວນ" v-model="amount1"></v-text-field>
                            <v-text-field dense outlined label="ລາຄາ/ອັນ" v-model="perAmount1"></v-text-field>
                            <v-text-field dense outlined label="ລາຄາທັງໝົດ" v-model="totalAmount1" readonly></v-text-field>
                            <v-menu ref="start_menu1" v-model="start_menu1" :close-on-content-click="false"
                                :return-value.sync="dateSave1" transition="scale-transition" offset-y min-width="auto">
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field dense outlined v-model="dateSave1" :rules="nameRules" required
                                        label="ວັນທີຈ່າຍຄ່າ" append-icon="mdi-calendar" readonly v-bind="attrs"
                                        v-on="on"></v-text-field>
                                </template>
                                <v-date-picker v-model="dateSave1" no-title scrollable
                                    @input="$refs.start_menu1.save(dateSave1)">
                                    <v-spacer></v-spacer>
                                </v-date-picker>
                            </v-menu>
                            <div class="d-flex align-center">
                                <v-spacer></v-spacer>
                                <v-btn elevation="0" color="red" class="white--text mr-2"
                                    @click="updateDia = false">ຍົກເລຶກ</v-btn>
                                <v-btn elevation="0" color="#4AAF41" class="white--text" @click="onUpdate">ອັບເດດ</v-btn>
                            </div>
                        </div>
                    </v-card-text>
                </v-card>
            </v-dialog>
            <div style="width:100%;height:80vh;border:1px solid #e0e0e0;border-radius:5px" class="ml-2">
                <div style="">
                    <v-card-title style="background-color:#568fb3;color:white">ຂໍ້ມູນລາຍຈ່າຍ</v-card-title>
                    <v-card-text class="pt-3">
                        <div style="padding-bottom:10px">
                            <span>ທັງໝົດ:
                                <span class="green--text" style="font-size: 12pt; font-weight: bold">{{
                                    expense_list?.length
                                        ?.toString()
                                        ?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
                                }}</span></span>
                        </div>
                        <v-divider></v-divider>
                        <div style="overflow: scroll;overflow-y: scroll;overflow-x: hidden;height:65vh">
                            <v-data-table :items="expense_list" :headers="expense_header">
                                <template v-slot:item="row">
                                    <tr>
                                        <td>{{ row?.item?.exPType }}</td>
                                        <td>{{ row?.item?.amount?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
                                        <td>{{ row?.item?.perAmount?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
                                        <td>{{ row?.item?.toTal?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
                                        <td>{{ row?.item?.cdate }}</td>
                                        <td>{{ row?.item?.expDate }}</td>
                                        <td>
                                            <v-btn color="#338ABF" small elevation="0"
                                                @click="onGetDaForUp(row?.item?.key_id, row?.item?.exPType, row?.item?.amount, row?.item?.perAmount, row?.item?.toTal, row?.item?.expDate)">
                                                <v-icon color="white">mdi-pencil</v-icon>
                                                <span class="white--text">ແກ້ໄຂ</span>
                                            </v-btn>
                                        </td>
                                        <td>
                                            <v-btn color="red" small elevation="0" @click="onDelete(row?.item?.key_id)">
                                                <v-icon color="white">mdi-delete</v-icon>
                                                <span class="white--text">ລົບ</span>
                                            </v-btn>
                                        </td>
                                    </tr>
                                </template>
                            </v-data-table>

                        </div>
                    </v-card-text>
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
            start_menu: false,
            dateSave: null,
            start_menu1: false,
            dateSave1: null,
            updateDia: false,
            expense_list: [],
            expense_header: [
                { text: 'ປະເພດຄ່າໃຊຈ່າຍ', value: 'exPType' },
                { text: 'ຈຳນວນ', value: 'amount' },
                { text: 'ຈຳນວນເງິນ', value: 'perAmount' },
                { text: 'ຈຳນວນເງິນທັງໝົດ', value: 'toTal' },
                { text: 'ວັນທີບັນທຶກ', value: 'cdate' },
                { text: 'ວັນທີຈ່າຍຄ່າ', value: 'cdate' },
                { text: '', value: '' },
                { text: '', value: '' },
            ],
            form: {},
            expense_list_type: [],
            type: '',
            totalAmount: '',
            perAmount: '',
            amount: '',
            type1: '',
            totalAmount1: '',
            perAmount1: '',
            amount1: '',
            valid: true,
            nameRules: [(v) => !!v || 'ຕ້ອງມີຂໍ້ມູນ'],
            key_up: '',
            list_expense_type_for_up: []
        }
    },
    mounted() {
        this.onGetExpenseTypeAll()
        this.onGetExpense()
    },
    watch: {
        amount: function (newValue) {
            const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.perAmount ? this.perAmount?.split(',').join('') : 1);
            this.totalAmount = (real_total)?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            const result = newValue?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
            this.amount = result
        },
        perAmount: function (newValue) {
            const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.amount ? this.amount?.split(',').join('') : 1);
            this.totalAmount = (real_total)?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            const result = newValue?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            this.perAmount = result;
        },
        amount1: function (newValue) {
            const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.perAmount1 ? this.perAmount1?.split(',').join('') : 1);
            this.totalAmount1 = (real_total)?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            const result = newValue?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
            this.amount1 = result
        },
        perAmount1: function (newValue) {
            const real_total = parseInt(newValue?.split(',').join('')) * parseInt(this.amount1 ? this.amount1?.split(',').join('') : 1);
            this.totalAmount1 = (real_total)?.toString()?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            const result = newValue?.replace(/\D/g, '')?.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            this.perAmount1 = result;
        },
    },
    methods: {
        onSave() {
            if (!this.$refs.form.validate()) return null
            let data = {
                exPType: this.type,
                toTal: this.totalAmount?.split(',').join(''),
                perAmount: this.perAmount?.split(',').join(''),
                amount: this.amount?.split(',').join(''),
                expDate: this.dateSave
            }
            try {
                this.$axios.$post('/storeExpenses.service', data).then((data) => {
                    if (data?.status === '00') {
                        this.$toast.success('ສຳເລັດແລ້ວ')
                        this.onGetExpense()
                        this.$refs.form.reset();
                    } else {
                        swal.fire({
                            icon: 'error',
                            text: data?.message
                        })
                    }
                })
            } catch (error) {
                console.log(error)
            }
        },
        onGetExpenseTypeAll() {
            try {
                this.$axios.$post('/getExpensesTypeAll.service').then((data) => {
                    this.expense_list_type = data?.data
                })
            } catch (error) {
                console.log(error)
            }
        },
        onGetExpense() {
            try {
                this.$axios.$post('/getExpensesAll.service').then((data) => {
                    this.expense_list = data?.data
                })
            } catch (error) {
                console.log(error)
            }
        },
        onGetDaForUp(key_id, exPType, amount, perAmount, toTal, date) {
            this.list_expense_type_for_up = this.expense_list_type.map((list) => {
                return list?.typeName
            })
            this.key_up = key_id
            this.type1 = exPType
            this.amount1 = amount
            this.perAmount1 = perAmount
            this.totalAmount1 = toTal
            this.dateSave1 = date
            this.updateDia = true
        },
        onDelete(key) {
            try {
                let data = {
                    key_id: key
                }
                this.$axios.$post('/storeExpensesDel.service', data).then((data) => {
                    if (data?.status === '00') {
                        this.$toast.success('ສຳເລັດແລ້ວ')
                        this.onGetExpense()
                    }
                })
            } catch (error) {
                console.log(error)
            }
        },
        onUpdate() {
            let datas = this.expense_list_type.filter((el) => el.typeName === this.type1);

            let data = {
                key_id: this.key_up,
                exPType: datas[0]?.key_id,
                toTal: this.totalAmount1?.split(',').join(''),
                perAmount: this.perAmount1?.split(',').join(''),
                amount: this.amount1?.split(',').join(''),
                exPName: '',
                expDate: this.dateSave1

            }
            console.log("send===", data)

            try {
                this.$axios.$post('/storeExpensesUpdate.service', data).then((data) => {

                    if (data?.status === '00') {
                        this.$toast.success('ສຳເລັດແລ້ວ')
                        this.onGetExpense()
                        this.updateDia = false
                    } else {
                        swal.fire({
                            icon: 'error',
                            text: data?.message
                        })
                    }
                })
            } catch (error) {
                console.log(error)
            }
        }
    }
}
</script>

<style></style>