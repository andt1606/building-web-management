package com.laptrinhjavaweb.api.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.AssignmentBuildingRequest;
import com.laptrinhjavaweb.dto.response.ResponseDTO;
import com.laptrinhjavaweb.dto.response.StaffResponseDTO;
import com.laptrinhjavaweb.service.impl.BuildingService;
import com.laptrinhjavaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @PostMapping("/building")
    public BuildingDTO createBuilding(@RequestBody BuildingDTO newBuilding){
        buildingService.saveBuilding(newBuilding);
        return newBuilding;
    }

    @DeleteMapping("/building")
    public void deleteBuildings(@RequestBody List<Long> ids) {
        buildingService.deleteBuilding(ids);
    }


    @GetMapping(value = "/building/{id}")
    public BuildingDTO getBuilding(@PathVariable("id") long id) {
        BuildingDTO dto = buildingService.getBuldingById(id);
        return dto;
    }

    @GetMapping("/building/{buildingId}/staffs")
    public ResponseDTO loadStaff(@PathVariable("buildingId") long id){
        ResponseDTO result = new ResponseDTO();
        List<StaffResponseDTO> staffs = userService.getStaffs(id);
        result.setMessage("success");
        result.setData(staffs);
        return result;
    }

    @PostMapping("/building-assignment")
    public void updateAssignmentUser(@RequestBody AssignmentBuildingRequest request){
        userService.assignmentBuilding(request);
    }

}
