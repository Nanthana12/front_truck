<template>
  <div class="pt-5">
    <v-dialog v-model="loading_processing" persistent width="55">
      <v-card width="55" height="55" class="pt-3 pl-3">
        <v-progress-circular :width="3" color="primary" indeterminate></v-progress-circular>
      </v-card>
    </v-dialog>

    <v-card class="card-shadow mx-auto" width="1200">
      <v-card-title style="display:flex;background-color:#568fb3;color:white">
        <v-btn fab elevation="0" dark width="30" height="30" small color="white " to="employee">
          <v-icon color="#338ABF">mdi-arrow-left</v-icon>
        </v-btn>
        <v-spacer></v-spacer>
        ເພີ່ມຂໍ້ມູນພະນັກງານ
        <v-spacer></v-spacer>
      </v-card-title>
      <v-card-text class="pa-8 mx-auto" width="1200" style="border:0px solid #e0e0e0">
        <v-form v-model="valid" lazy-validation ref="form">
          <v-row>
            <v-col cols="3" class="text-center">
              <height />
              <div class="text-center">
                <div v-if="imagePreview == ''">
                  <img src="../assets/images/profile.png" class="preview-image" v-on:click="openUpload" height="200px"
                    cover>
                </div>
                <div v-else>
                  <img v-bind:src="imagePreview" class="preview-image" v-on:click="openUpload" height="200px" cover>
                </div>
              </div>
              <input name="image" type="file" id="file-field" v-on:change="updagePreview" style="display: none;">

            </v-col>
            <v-col cols="9">
              <v-row>
                <v-col clos="6" md="6" sm="6">
                  <v-text-field :rules="nameRules" label="ລະຫັດພະນັກງານ" outlined dense v-model="emp_id"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ id_mess }}</span>
                  </div>
                </v-col>
              </v-row>
              <v-row>
                <v-col clos="6" md="6" sm="6">
                  <v-text-field :rules="nameRules" label="ຊື່" outlined dense v-model="emp_name"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ name_mess }}</span>
                  </div>
                </v-col>
                <v-col clos="6" md="6" sm="6">
                  <v-text-field :rules="nameRules" label="ນາມສະກຸນ" outlined dense v-model="emp_surname"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ sur_mess }}</span>
                  </div>
                </v-col>
              </v-row>
              <v-row>
                <v-col clos="6" md="4" sm="4">
                  <v-text-field :rules="nameRules" label="ບ້ານເກີດ" outlined dense v-model="emp_village"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ vill_mess }}</span>
                  </div>
                </v-col>
                <v-col clos="6" md="4" sm="4">
                  <v-text-field :rules="nameRules" label="ເມືອງ" outlined dense v-model="emp_district"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ dist_mess }}</span>
                  </div>
                </v-col>
                <v-col clos="6" md="4" sm="4">
                  <v-text-field :rules="nameRules" label="ແຂວງ" outlined dense v-model="emp_province"></v-text-field>
                  <div class="tops">
                    <span class="red--text">{{ prov_mess }}</span>
                  </div>
                </v-col>
              </v-row>
              <v-row>
                <v-col clos="6" md="4" sm="4">
                  <v-radio-group inline v-model="emp_gender" :rules="nameRules">
                    <v-row class="pl-3">
                      <span class="mt-1">ເພດ</span>
                      <Width />
                      <v-radio label="ຊາຍ" value="ຊາຍ" class="mt-1"></v-radio>
                      <Width />
                      <v-radio label="ຍິງ" value="ຍິງ"></v-radio>
                    </v-row>
                  </v-radio-group>
                  <div class="tops">
                  </div>
                </v-col>
                <v-col clos="6" md="4" sm="4">
                  <v-text-field :rules="nameRules" label="ສະຖານະ" outlined dense
                    v-model="emp_gender_status"></v-text-field>
                  <div class="tops">
                  </div>
                </v-col>
                <v-col clos="6" md="4" sm="4">
                  <v-text-field :rules="nameRules" label="ເລກທີໃບຂັບຂີ່" outlined dense type="number"
                    v-model="emp_licens_number"></v-text-field>
                  <div class="tops">
                  </div>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
          <v-row>
            <v-col clos="6" md="3" sm="3">
              <v-text-field :rules="nameRules" label="ໃບຂັບຂີ່ອອກທີ" outlined dense v-model="emp_verby"></v-text-field>
              <div class="tops">
              </div>
            </v-col>
            <v-col clos="6" md="3" sm="3">
              <v-text-field :rules="nameRules" label="ໃບຂັບຂີ່ໝົດອາຍຸ" outlined dense
                v-model="emp_licens_expire_date"></v-text-field>
              <div class="tops">
              </div>
            </v-col>
            <v-col clos="6" md="3" sm="3">
              <v-text-field :rules="nameRules" label="ເບີໂທ1" outlined dense type="number"
                v-model="emp_mobile"></v-text-field>
              <div class="tops">
              </div>
            </v-col>
            <v-col clos="6" md="3" sm="3">
              <v-text-field :rules="nameRules" label="ເບີໂທ2" outlined dense type="number"
                v-model="emp_mobile1"></v-text-field>
              <div class="tops">
              </div>
            </v-col>
          </v-row>
        </v-form>
        <Height />
        <Height />
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
      </v-card-text>
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
      imagePreview: '',
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
      image: '',
      /////////////
      em_userId: '',
      loading_processing: false,
      //message empty

      valid: true,
      nameRules: [(v) => !!v || 'ຕ້ອງປ້ອນຂໍ້ມູນ'],
    }
  },
  methods: {
    openUpload() {
      document.getElementById('file-field').click()
    },

    updagePreview(e, file) {
      var reader, files = e.target.files

      if (files.length === 0) {
        console.log('empty')
      }

      reader = new FileReader()

      reader.onload = (e) => {
        this.imagePreview = e.target.result
      }

      reader.readAsDataURL(files[0])

      if (file) {
        this.image = URL.createObjectURL(this.image)
        console.log(this.image)
      } else {
        this.image = null
      }
    },
    // onGetEmpImage(file) {
    //   if (file) {
    //     this.url = URL.createObjectURL(this.image)
    //     console.log(this.url)
    //   } else {
    //     this.url = null
    //   }
    // },
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
}

.preview-image {
  width: 220px;
  height: 220px;
}
</style>
