package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.service.impl.BuildingService;
import com.laptrinhjavaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController(value = "buildingAPIOfAdmin")
@RequestMapping("/api")
public class BuildingAPI {

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private UserService userService;

    /*@PostMapping("/building")
    public BuildingDTO createBuilding(@RequestBody BuildingDTO newBuilding){
        buildingService.saveBuilding(newBuilding);
        return newBuilding;
    }*/

    @PostMapping("/building")
    public ResponseEntity<BuildingDTO> createBuilding(@RequestBody BuildingDTO newBuilding){
        return ResponseEntity.ok(buildingService.saveBuilding(newBuilding));
    }

    /*@DeleteMapping("/building")
    public void deleteBuildings(@RequestBody List<Long> ids) {
        buildingService.deleteBuilding(ids);
    }*/

    @DeleteMapping("/building")
    public ResponseEntity<Void> deleteBuildings(@RequestBody List<Long> ids) {
        buildingService.deleteBuilding(ids);
        return ResponseEntity.noContent().build();
    }


    /*@GetMapping(value = "/building/{id}")
    public BuildingDTO getBuilding(@PathVariable("id") long id) {
        BuildingDTO dto = buildingService.getBuldingById(id);
        return dto;
    }*/
    @GetMapping(value = "/building/{id}")
    public ResponseEntity<BuildingDTO> getBuilding(@PathVariable("id") long id) {
        return ResponseEntity.ok(buildingService.getBuldingById(id));
    }

    /*@GetMapping("/building/{buildingId}/staffs")
    public ResponseDTO loadStaff(@PathVariable("buildingId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return result;
    }*/

    @GetMapping("/building/{buildingId}/staffs")
    public ResponseEntity<ResponseDTO> loadStaff(@PathVariable("buildingId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return ResponseEntity.ok(result);
    }

    /*@PostMapping("/building-assignment")
    public void updateAssignmentUser(@RequestBody AssignmentBuildingRequest request){
        userService.assignmentBuilding(request);
    }*/

    @PostMapping("/building-assignment")
    public ResponseEntity<Void> updateAssignmentUser(@RequestBody AssignmentBuildingRequest request){
        userService.assignmentBuilding(request);
        return ResponseEntity.noContent().build();
    }

}
