<template>
  <div>
    <v-dialog v-model="loading_processing" persistent width="55">
      <v-card width="55" height="55" class="pt-3 pl-3">
        <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
      </v-card>
    </v-dialog>
    <v-card class="card-shadow" rounded="lg">
      <v-card-title style="background-color:#568fb3" class="white--text">ລາຍງານລາຍຈ່າຍ</v-card-title>
      <v-card-text>
        <div class="d-flex align-center pt-4" style="width:100%">

          <div class="d-flex align-center">
            <v-menu ref="start_menu" v-model="start_menu" :close-on-content-click="false" :return-value.sync="start_date"
              transition="scale-transition" offset-y min-width="auto">
              <template v-slot:activator="{ on, attrs }">
                <v-text-field dense outlined v-model="start_date" required label="ວັນທີເລີ່ມຕົ້ນ"
                  append-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
              </template>
              <v-date-picker v-model="start_date" no-title scrollable @input="$refs.start_menu.save(start_date)">
                <v-spacer></v-spacer>
              </v-date-picker>
            </v-menu>
          </div>
          <div class="d-flex align-center pl-2">
            <v-menu ref="end_menu" v-model="end_menu" :close-on-content-click="false" :return-value.sync="end_date"
              transition="scale-transition" offset-y min-width="auto">
              <template v-slot:activator="{ on, attrs }">
                <v-text-field dense outlined v-model="end_date" required label="ວັນທີສຸດທ້າຍ" append-icon="mdi-calendar"
                  readonly v-bind="attrs" v-on="on"></v-text-field>
              </template>
              <v-date-picker v-model="end_date" no-title scrollable @input="$refs.end_menu.save(end_date)">
                <v-spacer></v-spacer>
              </v-date-picker>
            </v-menu>
          </div>
          <div style="margin-top:-25px" class="ml-2">
            <v-btn color="green" class="white--text" elevation="0"
              @click="onGetExpenseBySearch"><v-icon>mdi-magnify</v-icon>ຄົ້ນຫາ</v-btn>
          </div>
        </div>

        <div>
          <table style="padding:2px;border: 0.5px solid #999;border-collapse: collapse;width:100%">
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">

              <td style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000"
                class=" font-weight-bold text-center">
                ລ/ດ</td>
              <td style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000"
                class=" font-weight-bold">
                ຊື່ຄ່າໃຊ້ຈ່າຍ</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" font-weight-bold">ວັນທີບັນທຶກ</td>
                <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" font-weight-bold">ວັນທີຈ່າຍຄ່າ</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" font-weight-bold">ຈຳນວນ</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" font-weight-bold">ລາຄາ/ອັນ</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" font-weight-bold">ລາຄາລວມ</td>

            </tr>
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px"
              v-for="(item, i) in report_expense_list" :key="i">
              <td style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000"
                class="  text-center">
                {{ i + 1 }}</td>

              <td style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000" class=" ">
                {{ item?.exPType }}</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" ">{{ item?.cdate }}</td>
                <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class=" ">{{ item?.expDate }}</td>
              <td
              
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                >{{ item?.amount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }}</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                >{{ item?.perAmount?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} LAK</td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px"
                class="red--text">{{ item?.toTal?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} LAK</td>

            </tr>
            <tr style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;border-radius:10px">

              
              <td colspan="6"
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;font-size:14pt"
                class="font-weight-bold text-right">
                ລວມລາຍຈ່າຍທັງໝົດ:
              </td>
              <td
                style="padding:10px;border: 0.5px solid #999;border-collapse: collapse;color:#000;border-top-right-radius:3px;font-size:16pt"
                class="font-weight-bold red--text">
                {{ sumTotalPrice?.toString()?.replace(/\B(?=(\d{3})+(?!\d))/g, ',') }} LAK
              </td>

            </tr>
          </table>
        </div>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
import swal from 'sweetalert2';
export default {
  data() {
    return {
      loading_processing: false,
      end_menu: false,
      end_date: null,
      start_menu: false,
      start_date: null,
      report_expense_list: [],
      report_expense_header: [
        { text: 'ລ/ດ', value: '' },
        { text: 'ຊື່ຄ່າໃຊ້ຈ່າຍ', value: 'exPType' },
        { text: 'ຈຳນວນ', value: 'amount' },
        { text: 'ລາຄາ/ອັນ', value: 'perAmount' },
        { text: 'ລາຄາລວມ', value: 'toTal' },
        { text: 'ວັນທີ', value: 'cdate' }
      ],
      sumTotalPrice: ''
    }
  },
  mounted() {
    this.onGetAll()
  },
  watch: {
    report_expense_list: function () {
      const sum = this.report_expense_list?.reduce((a, o) => {
        return parseFloat(a) + parseFloat(o?.toTal?.split(',')?.join(''))
      }, 0)
      this.sumTotalPrice = sum

    },
  },
  methods: {
    onGetAll() {
      try {
        this.loading_processing = true;
        this.$axios.$post('/getExpensesAll.service').then((data) => {
          this.report_expense_list = data?.data
          this.loading_processing = false
        })
      } catch (error) {
        this.loading_processing = false
        swal.fire({
          icon: 'error',
          text: error
        })
        console.log(error)
      }
    },
    onGetExpenseBySearch() {
      try {
        let data = {
          startDate: this.start_date,
          endDate: this.end_date
        }
        this.loading_processing = true;
        this.$axios.$post('/getExpenses.service', data).then((data) => {
          this.report_expense_list = data?.data
          this.loading_processing = false
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