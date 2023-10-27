<template>
  <v-app dark>
    <v-app-bar fixed app color="#E57373">
      <v-dialog v-model="loading_processing" persistent width="55">
        <v-card width="55" height="55" class="pt-3 pl-3">
          <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
        </v-card>
      </v-dialog>

      <v-btn class="mx-2" fab dark small color="white">
        <img class="mx-auto" src="../assets/images/khounkham.png" width="80" />
      </v-btn>
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="white" v-bind="attrs" v-on="on" text class="ml-2" elevation="0">
            <v-icon color="#fff" size="18">mdi-hammer-wrench</v-icon>
            ຈັດການຂໍ້ມູນພື້ນຖານ
            <v-icon color="#fff">mdi-chevron-down</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-btn color="white" to="customer" elevation="0" block><span
              class="black--text">ເພີ່ມລູກຄ້າ</span><v-spacer></v-spacer></v-btn>

          <v-btn color="white" to="employee" elevation="0" block><span
              class="black--text">ເພີ່ມພະນັກງານ</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="user" elevation="0" block><span
              class="black--text">ເພີ່ມຜູ້ເຂົ້າໃຊ້</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="products" elevation="0" block><span
              class="black--text">ເພີ່ມສິນຄ້າ</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="locations" elevation="0" block><span
              class="black--text">ເພີ່ມສະຖານທີຈັດສົ່ງ</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="exchang" elevation="0" block><span
              class="black--text">ເພີ່ມອັດຕາການແລກປ່ຽນ</span><v-spacer></v-spacer></v-btn>
              <v-btn color="white" to="morfai" elevation="0" block><span
              class="black--text">ເພີ່ມຍີ່ຫໍ້ໝໍ້ໄຟ</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="create-expense-type" elevation="0" block><span
              class="black--text">ເພີ່ມປະເພດລາຍຈ່າຍ</span><v-spacer></v-spacer></v-btn>
          <v-btn color="white" to="create-expense" elevation="0" block><span
              class="black--text">ເພີ່ມລາຍຈ່າຍ</span><v-spacer></v-spacer></v-btn>
        </v-list>
      </v-menu>


      <!-- <v-btn color="white" class="ml-2" to="cars_14"><v-icon color="#999" size="18">mdi-car</v-icon><span
          class="black--text">ຂໍ້ມູນລົດ</span></v-btn> -->
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="white" v-bind="attrs" v-on="on" text class="ml-2" elevation="0">
            <v-icon color="#fff" size="18">mdi-car-outline</v-icon> ຂໍ້ມູນລົດ
            <v-icon color="#fff">mdi-chevron-down</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-btn block color="white" class="text-left" elevation="0" style="border-radius: 0px" to="/cars_14">
            ຂໍ້ມູນຫົວລົດ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn block color="white" elevation="0" style="border-radius: 0px" to="/cars_footer">
            ຂໍ້ມູນຫາງລົດ
            <v-spacer></v-spacer>
          </v-btn>
        </v-list>
      </v-menu>
      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="white" v-bind="attrs" v-on="on" text class="ml-2" elevation="0">

            <v-tab>
              <v-icon color="#fff" size="18">mdi-text-box-check-outline</v-icon>
                ສ້າງໃບບິນ
              <v-badge color="#FF3D00" v-if="TOTAL!= '0'" :content='TOTAL' >
               
              </v-badge>
            </v-tab>

            <v-icon color="#fff">mdi-chevron-down</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-btn block color="white" class="text-left" elevation="0" style="border-radius: 0px" to="/leave-cars-list">
            ອອກໃບປ່ອຍລົດ
            <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_notiDetails != '0'">
              {{ TOTAL_notiDetails }}
            </v-chip>
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/operation-list">
            ອອກໃບປະຕີບັດງານ
            <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_FORMANCE != '0'">
              {{ TOTAL_FORMANCE }}
            </v-chip>
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/invoice-list">
            ອອກໃບບິນຂົນສົ່ງ
            <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_INVOICE != '0'">
              {{ TOTAL_INVOICE }}
            </v-chip>
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/payment">

            ຮັບເງິນ
            <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_payStatus != '0'">
              {{ TOTAL_payStatus }}
            </v-chip>
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/payment-debt">
            ຮັບເງິນຍອດຫຼັງ
            <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_totalOwe != '0'">
              {{ TOTAL_totalOwe }}
            </v-chip>
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/allowance">
            ບ້ຽງລ້ຽງທີ່ຄ້າງຊໍາລະ
            <!-- <v-chip class="ma-2" x-small color="red" text-color="white" v-if="TOTAL_totalOwe != '0'">
              {{ TOTAL_totalOwe }} -->
            <!-- </v-chip> -->
            <v-spacer></v-spacer>
          </v-btn>
        </v-list>
      </v-menu>
      <!-- <v-btn color="white" to="leave_cars" class="ml-2"><v-icon color="#999" size="18">mdi-car-arrow-right</v-icon><span
          class="black--text">ປ່ອຍລົດ</span></v-btn> -->

      <v-menu offset-y>
        <template v-slot:activator="{ on, attrs }">
          <v-btn color="white" v-bind="attrs" v-on="on" text class="ml-2" elevation="0">
            <v-icon color="#fff" size="18">mdi-poll</v-icon>
            ລາຍງານ
            <v-icon color="#fff">mdi-chevron-down</v-icon>
          </v-btn>
        </template>
        <v-list>
          <v-btn color="white" block class="text-left" elevation="0" style="border-radius: 0px" to="/report_customers">
            ລາຍງານລູກຄ້າ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report_staft">
            ລາຍງານພະນັກງານ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report_products">
            ລາຍງານສິນຄ້າ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report_leave_cars">
            ລາຍງານໃບປ່ອຍລົດ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report_operation">
            ລາຍງານໃບປະຕິບັດງານ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report_invoice">
            ລາຍງານໃບບິນຂົນສົ່ງສິນຄ້າ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report-payment">
            ລາຍງານໃບບິນຮັບເງິນ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/income_empeanses_car">
            ລາຍງານລາຍຮັບ - ລາຍຈ່າຍຂອງລົດ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report-income">
            ລາຍງານລາຍຮັບ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report-expense">
            ລາຍງານລາຍຈ່າຍ
            <v-spacer></v-spacer>
          </v-btn>
          <v-btn color="white" block elevation="0" style="border-radius: 0px" to="/report-customer-debt">
            ລາຍງານລູກຄ້າຕິດໜີ້
            <v-spacer></v-spacer>
          </v-btn>
        </v-list>
      </v-menu>

      <v-spacer />
      <v-btn rounded elevation="0" text>
        <v-icon color="#fff">mdi-account</v-icon>
        <span class="white--text">{{ USER_NAME }}</span>
      </v-btn>

      <v-btn rounded @click="onLogOut" text elevation="0">
        <v-icon color="white">mdi-power</v-icon>

      </v-btn>
    </v-app-bar>



    <div id="ifmcontentstoprint">cooking</div>

    <v-main class="bg">
      <div class="cont">
        <Nuxt />
      </div>
    </v-main>
  </v-app>
</template>

<script>
import swal from 'sweetalert2'
export default {
  data() {
    return {
      USER_ID: '',
      USER_NAME: '',
      USER_ROLE: '',
      TOTAL: '',
      TOTAL_INVOICE: '',
      TOTAL_FORMANCE: '',
      TOTAL_payStatus: '',
      TOTAL_totalOwe: '',
      TOTAL_notiDetails: '',
      loading_processing: false,
    }
  },
  mounted() {
    this.USER_ID = localStorage.getItem('USER_ID')
    this.USER_NAME = localStorage.getItem('USER_NAME')
    this.USER_ROLE = localStorage.getItem('USER_ROLE')
    this.total_count()
  },
  methods: {
    onPrint() {
      window.print()
    },

    onLogOut() {
      localStorage.clear()
      this.$router.push('/')
    },

    total_count() {
      try {
        this.loading_processing = true;
        this.$axios.$post('/getNotiTab3.service').then((data) => {
          this.loading_processing = false
          this.TOTAL = data?.totalRow
          this.TOTAL_INVOICE = data?.notiInvoice
          this.TOTAL_FORMANCE = data?.notiPerForMance
          this.TOTAL_payStatus = data?.payStatus
          this.TOTAL_notiDetails = data?.notiDetails
          this.TOTAL_totalOwe = data?.totalOwe
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
  },
}
</script>
<style lang="scss">
.bg {
  background-color: white;
}

.cont {
  padding-left: 70px;
  padding-right: 85px;
  padding-top: 0px
}
</style>
