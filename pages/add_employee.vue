<template>
  <div class="pt-5">
    <v-dialog v-model="loading_processing" persistent width="55">
      <v-card width="55" height="55" class="pt-3 pl-3">
        <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
      </v-card>
    </v-dialog>
    <v-card color="pl-10 pt-10 pr-10" width="1000" class="mx-auto" flat style="border:1px solid #e0e0e0">
      <v-row class="pa-2">
        <!-- <v-btn fab outlined small color="indigo" to="employee">
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn> -->
        <v-btn fab small width="30" height="30" color="#338ABF" to="employee">
          <v-icon color="white">mdi-arrow-left</v-icon>
        </v-btn>
        <span class="mt-1 ml-2">ເພີ່ມຂໍ້ມູນພະນັກງານ</span>
      </v-row>
      <Height />
      <Height />
      <Height />
      <v-form v-model="valid" lazy-validation ref="form">
        <v-row>
          <v-col cols="6" md="4" sm="4">
            <v-text-field :rules="nameRules" label="ລະຫັດພະນັກງານ" outlined dense v-model="emp_id"></v-text-field>
            <div class="tops">
              <span class="red--text pl-1">{{ id_mess }}</span>
            </div>
          </v-col>
          <v-col cols="6" md="4" sm="4"><v-text-field :rules="nameRules" label="ຊື່" outlined dense
              v-model="emp_name"></v-text-field>
            <div class="tops">
              <span class="red--text pl-1">{{ name_mess }}</span>
            </div>
          </v-col><v-col cols="6" md="4" sm="4">
            <v-text-field :rules="nameRules" label="ນາມສະກຸນ" outlined dense v-model="emp_surname"></v-text-field>
            <div class="tops">
              <span class="red--text pl-1">{{ sur_mess }}</span>
            </div>
          </v-col>
        </v-row>
        <div class="margintops">
          <v-row>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ບ້ານເກີດ" outlined dense v-model="emp_village"></v-text-field>
              <div class="tops">
                <span class="red--text pl-1">{{ vill_mess }}</span>
              </div>
            </v-col>
            <v-col cols="6" md="4" sm="4"><v-text-field :rules="nameRules" label="ເມືອງ" outlined dense
                v-model="emp_district"></v-text-field>
              <div class="tops">
                <span class="red--text pl-1">{{ dist_mess }}</span>
              </div>
            </v-col><v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ແຂວງ" outlined dense v-model="emp_province"></v-text-field>
              <div class="tops">
                <span class="red--text pl-1">{{ prov_mess }}</span>
              </div>
            </v-col>
          </v-row>
        </div>
        <div class="margintops">
          <v-row>
            <v-col cols="6" md="4" sm="4">
              <v-radio-group inline v-model="emp_gender" :rules="nameRules">
                <v-row class="pl-3">
                  <span class="mt-1">ເພດ</span>
                  <Width />
                  <v-radio label="ຊາຍ" value="ຊາຍ" class="mt-1"></v-radio>
                  <Width />
                  <v-radio label="ຍິງ" value="ຍິງ"></v-radio>
                </v-row>
              </v-radio-group>

            </v-col>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ສະຖານະ" outlined dense v-model="emp_gender_status"></v-text-field>

            </v-col>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ເລກທີໃບຂັບຂີ່" outlined dense type="number"
                v-model="emp_licens_number"></v-text-field>

            </v-col>
          </v-row>
        </div>
        <div class="margintops">
          <v-row>

            <v-col cols="6" md="4" sm="4"><v-text-field :rules="nameRules" label="ໃບຂັບຂີ່ອອກທີ" outlined dense
                v-model="emp_verby"></v-text-field>

            </v-col>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ໃບຂັບຂີ່ໝົດອາຍຸ" outlined dense
                v-model="emp_licens_expire_date"></v-text-field>

            </v-col>
            <v-col cols="6" md="4" sm="4">
              <!-- <v-text-field :rules="nameRules" label="ເລກທີບັດປະຈຳຕົວ" outlined dense type="number" v-model="emp_card_number"></v-text-field> -->

            </v-col>
          </v-row>
        </div>
        <div class="margintops">
          <v-row>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ເບີໂທ1" outlined dense type="number"
                v-model="emp_mobile"></v-text-field>
            </v-col>
            <v-col cols="6" md="4" sm="4">
              <v-text-field :rules="nameRules" label="ເບີໂທ2" outlined dense type="number"
                v-model="emp_mobile1"></v-text-field>
            </v-col>
          </v-row>
        </div>
      </v-form>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="red" @click="onClearData">
          <v-icon color="white">mdi-close</v-icon>
          <span class="white--text">ລ້າງຂໍ້ມູນ</span>
        </v-btn>
        <v-btn color="#338ABF" @click="onInserEmpInfo">
          <v-icon color="white">mdi-check</v-icon>
          <span class="white--text">ບັນທຶກ</span>
        </v-btn>
      </v-card-actions>

      <Height />
      <Height />
      <Height />
    </v-card>
  </div>
</template>
<script>
import swal from 'sweetalert2'
export default {
  data() {
    return {
      url: null,
      image: null,
      driver_licens_issued: false,
      driver_licens_expire: false,
      //inser state
      emp_id: '',
      emp_name: '',
      emp_surname: '',
      emp_village: '',
      emp_district: '',
      emp_province: '',
      emp_gender: 'ຊາຍ',
      emp_gender_status: '',
      emp_card_number: '',
      emp_licens_number: '',
      emp_licens_expire_date: '',
      emp_mobile: '',
      emp_mobile1: '',
      emp_verby: '',
      /////////////
      em_userId: '',
      loading_processing: false,
      //message empty

      valid: true,
      nameRules: [(v) => !!v || 'ຕ້ອງປ້ອນຂໍ້ມູນ'],
    }
  },
  methods: {
    onGetEmpImage(file) {
      if (file) {
        this.url = URL.createObjectURL(this.image)
        console.log(this.url)
      } else {
        this.url = null
      }
    },
    onClearData() {
      this.$refs.form.reset();
      setTimeout(() => this.emp_gender = 'ຊາຍ', 1000)
    },
    async onInserEmpInfo() {
      if (!this.$refs.form.validate()) return null
      try {

        let data = {
          staftId: this.emp_id,
          name: this.emp_name,
          surname: this.emp_surname,
          idCard: this.emp_card_number,
          licenceId: this.emp_licens_number,
          verBy: this.emp_verby,
          licenceExp: this.emp_licens_expire_date,
          vaillage: this.emp_village,
          district: this.emp_district,
          province: this.emp_province,
          mobile: this.emp_mobile,
          mobile1: this.emp_mobile1,
          gender: this.emp_gender,
          genderStatus: this.emp_gender_status,
          userId: localStorage.getItem('USER_ID'),
        }
        this.loading_processing = true
        console.log('send:', data)
        await this.$axios.$post('StoreStaft', data).then((data) => {
          if (data?.status == '00') {
            this.loading_processing = false
            swal.fire({
              title: 'ສຳເລັດ',
              icon: 'success',
              allowOutsideClick: false,

            })
            this.onClearData()
          } else {
            this.loading_processing = false
            swal.fire({
              title: 'ແຈ້ງເຕືອນ',
              text: data?.message,
              icon: 'error',
              allowOutsideClick: false,
              confirmButtonColor: '#3085d6',
              confirmButtonText: 'OK',
            })
          }
        })

      } catch (error) {
        this.loading_processing = false
        swal.fire({
          title: 'ແຈ້ງເຕືອນ',
          text: error,
          icon: 'error',
          allowOutsideClick: false,
          confirmButtonColor: '#3085d6',
          confirmButtonText: 'OK',
        })
      }
    },
  },
}
</script>
<style lang="scss">
.margintops {
  margin-top: -25px;
}

.top {
  margin-top: 5px;
  margin-left: 10px;
}

.tops {
  margin-top: -25px;
  font-size: 14px;
}</style>
